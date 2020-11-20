import 'dart:io';

import 'package:flutter/material.dart';
import 'package:i_moon/constants.dart';
import 'package:jitsi_meet/feature_flag/feature_flag_enum.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:jitsi_meet/jitsi_meeting_listener.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class JoinMeeting extends StatefulWidget {
  @override
  _JoinMeetingState createState() => _JoinMeetingState();
}

class _JoinMeetingState extends State<JoinMeeting> {
  String companyName = "iMoon";

  var roomCode = TextEditingController();
  var nameText = TextEditingController();

  bool isAudioMuted = true;
  bool isVideoMuted = true;

  @override
  void initState() {
    super.initState();
    JitsiMeet.addListener(JitsiMeetingListener(
        onConferenceWillJoin: _onConferenceWillJoin,
        onConferenceJoined: _onConferenceJoined,
        onConferenceTerminated: _onConferenceTerminated,
        onError: _onError));
  }

  @override
  void dispose() { 
    super.dispose();
    JitsiMeet.removeAllListeners();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 24),
              Text(
                "Room Code",
                style: TextStyle(
                  fontSize: 20,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              PinCodeTextField(
                appContext: context,
                length: 6,
                autoDisposeControllers: false,
                animationType: AnimationType.slide,
                pinTheme: PinTheme(shape: PinCodeFieldShape.underline),
                animationDuration: Duration(milliseconds: 300),
                controller: roomCode,
                onChanged: (value) {},
              ),
              SizedBox(height: 10),
              TextField(
                controller: nameText,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Full name",
                  labelStyle: TextStyle(
                      fontSize: 20,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 16),
              Divider(
                height: 48,
                thickness: 2.0,
              ),
              CheckboxListTile(
                value: isVideoMuted,
                onChanged: _onVideoMutedChanged,
                title: Text(
                  "Video Muted",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 16),
              CheckboxListTile(
                value: isAudioMuted,
                onChanged: _onAudioMutedChanged,
                title: Text(
                  "Audio Muted",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Divider(
                height: 48,
                thickness: 2.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                width: size.width * 0.8,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(29),
                  child: FlatButton(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    color: kPrimaryColor,
                    onPressed: () {
                      _joinMeeting();
                    },
                    child: Text(
                      "Join meeting",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _joinMeeting() async {
    try {
      Map<FeatureFlagEnum, bool> featureFlags = {
        FeatureFlagEnum.WELCOME_PAGE_ENABLED: false,
      };

      if (Platform.isAndroid) {
        featureFlags[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
      } else if (Platform.isIOS) {
        featureFlags[FeatureFlagEnum.PIP_ENABLED] = false;
      }

      var options = JitsiMeetingOptions()
        ..room = companyName + roomCode.text
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted
        ..userDisplayName = nameText.text
        ..featureFlags.addAll(featureFlags);

      debugPrint("JitsiMeetingOptions: $options");
      await JitsiMeet.joinMeeting(
        options,
        listener: JitsiMeetingListener(onConferenceWillJoin: ({message}) {
          debugPrint("${options.room} will join with message: $message");
        }, onConferenceJoined: ({message}) {
          debugPrint("${options.room} joined with message: $message");
        }, onConferenceTerminated: ({message}) {
          debugPrint("${options.room} terminated with message: $message");
        }),
      );
    } catch (error) {
      debugPrint("error: $error");
    }
  }

  _onAudioMutedChanged(bool value) {
    setState(() {
      isAudioMuted = value;
    });
  }

  _onVideoMutedChanged(bool value) {
    setState(() {
      isVideoMuted = value;
    });
  }

  void _onConferenceWillJoin({message}) {
    debugPrint("_onConferenceWillJoin broadcasted with message: $message");
  }

  void _onConferenceJoined({message}) {
    debugPrint("_onConferenceJoined broadcasted with message: $message");
  }

  void _onConferenceTerminated({message}) {
    debugPrint("_onConferenceTerminated broadcasted with message: $message");
  }

  _onError(error) {
    debugPrint("_onError broadcasted: $error");
  }
}
