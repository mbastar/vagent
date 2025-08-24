import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/components/menu/menu_widget.dart';
import '/components/message_bubbles/message_bubbles_widget.dart';
import '/components/settings/settings_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_timer.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'dart:async';
import '/custom_code/actions/index.dart' as actions;
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (FFAppState().sessionID == '') {
        await actions.generateSessionID();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0.0),
          child: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            automaticallyImplyLeading: false,
            actions: const [],
            centerTitle: true,
            elevation: 0.0,
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                  child: Builder(
                    builder: (context) {
                      final msg = FFAppState().messageHistory.toList();

                      return ListView.separated(
                        padding: const EdgeInsets.fromLTRB(
                          0,
                          10.0,
                          0,
                          10.0,
                        ),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: msg.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10.0),
                        itemBuilder: (context, msgIndex) {
                          final msgItem = msg[msgIndex];
                          return Container(
                            child: MessageBubblesWidget(
                              key: Key('Keyjml_${msgIndex}_of_${msg.length}'),
                              messageText: msgItem.text,
                              blueBubble: msgItem.blueBubble,
                            ),
                          );
                        },
                        controller: _model.listViewController,
                      );
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 2.0),
              child: Container(
                decoration: const BoxDecoration(),
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: 180.0,
                      decoration: const BoxDecoration(),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 0.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 36.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  FlutterFlowIconButton(
                                    borderRadius: 8.0,
                                    buttonSize: 40.0,
                                    disabledIconColor: const Color(0xFFAFAFAF),
                                    icon: FaIcon(
                                      FontAwesomeIcons.cog,
                                      color: FlutterFlowTheme.of(context).info,
                                      size: 24.0,
                                    ),
                                    onPressed: (_model.isRecording ||
                                            _model.isTranscribing)
                                        ? null
                                        : () async {
                                            await showModalBottomSheet(
                                              isScrollControlled: true,
                                              backgroundColor:
                                                  Colors.transparent,
                                              context: context,
                                              builder: (context) {
                                                return GestureDetector(
                                                  onTap: () =>
                                                      FocusScope.of(context)
                                                          .unfocus(),
                                                  child: Padding(
                                                    padding:
                                                        MediaQuery.viewInsetsOf(
                                                            context),
                                                    child: const SettingsWidget(),
                                                  ),
                                                );
                                              },
                                            ).then(
                                                (value) => safeSetState(() {}));
                                          },
                                  ),
                                ],
                              ),
                            ),
                            if (!_model.showWaveform)
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  SizedBox(
                                    width: 150.0,
                                    height: 150.0,
                                    child: Stack(
                                      alignment: const AlignmentDirectional(0.0, 0.0),
                                      children: [
                                        if (!(_model.isRecording ||
                                            _model.isTranscribing))
                                          FlutterFlowIconButton(
                                            borderRadius: 100.0,
                                            buttonSize: 120.0,
                                            fillColor: const Color(0xFF131313),
                                            icon: Icon(
                                              Icons.mic_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              size: 60.0,
                                            ),
                                            showLoadingIndicator: true,
                                            onPressed: () async {
                                              var shouldSetState = false;
                                              _model.settingsOK = await actions
                                                  .validateSettings();
                                              shouldSetState = true;
                                              if (!_model.settingsOK!) {
                                                await showModalBottomSheet(
                                                  isScrollControlled: true,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  context: context,
                                                  builder: (context) {
                                                    return GestureDetector(
                                                      onTap: () =>
                                                          FocusScope.of(context)
                                                              .unfocus(),
                                                      child: Padding(
                                                        padding: MediaQuery
                                                            .viewInsetsOf(
                                                                context),
                                                        child: const SettingsWidget(),
                                                      ),
                                                    );
                                                  },
                                                ).then((value) =>
                                                    safeSetState(() {}));

                                                if (shouldSetState) {
                                                  safeSetState(() {});
                                                }
                                                return;
                                              }
                                              unawaited(
                                                () async {
                                                  await actions
                                                      .startTextRecording();
                                                }(),
                                              );
                                              _model.isRecording = true;
                                              _model.showTextInput = false;
                                              safeSetState(() {});
                                              if (shouldSetState) {
                                                safeSetState(() {});
                                              }
                                            },
                                          ),
                                        if (_model.isRecording)
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(0.0, 0.0),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                var shouldSetState = false;
                                                // Recording stopped
                                                _model.isRecording = false;
                                                // Transcription started
                                                _model.isTranscribing = true;
                                                _model.showTextInput = false;
                                                safeSetState(() {});
                                                // Run STT
                                                _model.recordingError =
                                                    await actions
                                                        .stopTextRecording();
                                                shouldSetState = true;
                                                if (!getJsonField(
                                                  _model.recordingError,
                                                  r'''$.success''',
                                                )) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        getJsonField(
                                                          _model.recordingError,
                                                          r'''$.message''',
                                                        ).toString(),
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                        ),
                                                      ),
                                                      duration: const Duration(
                                                          milliseconds: 5000),
                                                      backgroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .error,
                                                    ),
                                                  );
                                                  _model.showTextInput = true;
                                                  _model.isTranscribing = false;
                                                  if (shouldSetState) {
                                                    safeSetState(() {});
                                                  }
                                                  return;
                                                }
                                                // Store STT result
                                                _model.queryText = FFAppState()
                                                    .speechToTextResponse;
                                                safeSetState(() {});
                                                // Add blue bubble with STT result
                                                FFAppState()
                                                    .addToMessageHistory(
                                                        MessageStruct(
                                                  text: FFAppState()
                                                      .speechToTextResponse,
                                                  blueBubble: true,
                                                ));
                                                safeSetState(() {});
                                                // Wait for UI elements
                                                await Future.delayed(
                                                    const Duration(
                                                        milliseconds: 100));
                                                // Scroll bubbles
                                                await _model.listViewController
                                                    ?.animateTo(
                                                  _model.listViewController!
                                                      .position.maxScrollExtent,
                                                  duration: const Duration(
                                                      milliseconds: 100),
                                                  curve: Curves.ease,
                                                );
                                                // Call webhook
                                                _model.getResponseAPICall =
                                                    await GetAgentResponseCall
                                                        .call(
                                                  prompt: FFAppState()
                                                      .speechToTextResponse,
                                                  webhookURL:
                                                      FFAppState().webhookURL,
                                                  webhookAuthValue: FFAppState()
                                                      .webhookAuthValue,
                                                  sessionID:
                                                      FFAppState().sessionID,
                                                );

                                                shouldSetState = true;
                                                if ((_model.getResponseAPICall
                                                        ?.succeeded ??
                                                    true)) {
                                                  // Run TTS for webhook response
                                                  _model.speechDuration =
                                                      await actions
                                                          .fetchSpeechAndPlay(
                                                    GetAgentResponseCall.speech(
                                                      (_model.getResponseAPICall
                                                              ?.jsonBody ??
                                                          ''),
                                                    ).toString(),
                                                    FFAppState().apiKey,
                                                  );
                                                  shouldSetState = true;
                                                  // Set timer value (playback length)
                                                  FFAppState().timerValue =
                                                      _model.speechDuration!;
                                                  FFAppState()
                                                      .speechToTextResponse = '';
                                                  safeSetState(() {});
                                                  // Transcription started
                                                  _model.isTranscribing = false;
                                                  _model.showTextInput = false;
                                                  // Show waveform
                                                  _model.showWaveform = true;
                                                  safeSetState(() {});
                                                  // Wait for UI elements (timer)
                                                  await Future.delayed(
                                                      const Duration(
                                                          milliseconds: 100));
                                                  // Start timer
                                                  _model.timerController
                                                      .onStartTimer();
                                                  // Add grey bubble to conversation
                                                  FFAppState()
                                                      .addToMessageHistory(
                                                          MessageStruct(
                                                    text: GetAgentResponseCall
                                                        .text(
                                                      (_model.getResponseAPICall
                                                              ?.jsonBody ??
                                                          ''),
                                                    ).toString(),
                                                  ));
                                                  safeSetState(() {});
                                                  // Wait for UI elements
                                                  await Future.delayed(
                                                      const Duration(
                                                          milliseconds: 100));
                                                  // Scroll bubbles
                                                  await _model
                                                      .listViewController
                                                      ?.animateTo(
                                                    _model
                                                        .listViewController!
                                                        .position
                                                        .maxScrollExtent,
                                                    duration: const Duration(
                                                        milliseconds: 100),
                                                    curve: Curves.ease,
                                                  );
                                                } else {
                                                  // Display error message in UI
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        (_model.getResponseAPICall
                                                                    ?.jsonBody ??
                                                                '')
                                                            .toString(),
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                        ),
                                                      ),
                                                      duration: const Duration(
                                                          milliseconds: 5000),
                                                      backgroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .error,
                                                    ),
                                                  );
                                                  _model.showTextInput = true;
                                                  _model.isTranscribing = false;
                                                }

                                                if (shouldSetState) {
                                                  safeSetState(() {});
                                                }
                                              },
                                              child: Lottie.asset(
                                                'assets/lottie_animations/Stop_Recording.json',
                                                width: 150.0,
                                                height: 150.0,
                                                fit: BoxFit.contain,
                                                animate: true,
                                              ),
                                            ),
                                          ),
                                        if (_model.isTranscribing)
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(0.0, 0.0),
                                            child: Container(
                                              width: 120.0,
                                              height: 120.0,
                                              decoration: const BoxDecoration(
                                                color: Color(0xFF131313),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Align(
                                                alignment: const AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Lottie.asset(
                                                  'assets/lottie_animations/Loading.json',
                                                  width: 120.0,
                                                  height: 120.0,
                                                  fit: BoxFit.contain,
                                                  animate: true,
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 36.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  FlutterFlowIconButton(
                                    borderRadius: 8.0,
                                    buttonSize: 40.0,
                                    disabledIconColor: const Color(0xFFAFAFAF),
                                    icon: FaIcon(
                                      FontAwesomeIcons.ellipsisV,
                                      color: FlutterFlowTheme.of(context).info,
                                      size: 24.0,
                                    ),
                                    onPressed: (_model.isRecording ||
                                            _model.isTranscribing)
                                        ? null
                                        : () async {
                                            await showModalBottomSheet(
                                              isScrollControlled: true,
                                              backgroundColor:
                                                  Colors.transparent,
                                              context: context,
                                              builder: (context) {
                                                return GestureDetector(
                                                  onTap: () =>
                                                      FocusScope.of(context)
                                                          .unfocus(),
                                                  child: Padding(
                                                    padding:
                                                        MediaQuery.viewInsetsOf(
                                                            context),
                                                    child: const MenuWidget(),
                                                  ),
                                                );
                                              },
                                            ).then(
                                                (value) => safeSetState(() {}));
                                          },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (_model.showWaveform)
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          await actions.interruptSpeech();
                          _model.isRecording = false;
                          _model.showWaveform = false;
                          _model.showTextInput = true;
                          safeSetState(() {});
                          _model.timerController.onStopTimer();
                        },
                        child: Lottie.asset(
                          'assets/lottie_animations/Animation_-_1700152506198.json',
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: 160.0,
                          fit: BoxFit.fill,
                          animate: true,
                        ),
                      ),
                    if (_model.showWaveform)
                      FlutterFlowTimer(
                        initialTime: valueOrDefault<int>(
                          FFAppState().timerValue,
                          1000,
                        ),
                        getDisplayTime: (value) =>
                            StopWatchTimer.getDisplayTime(
                          value,
                          hours: false,
                          minute: false,
                          milliSecond: false,
                        ),
                        controller: _model.timerController,
                        updateStateInterval: const Duration(milliseconds: 1000),
                        onChanged: (value, displayTime, shouldUpdate) {
                          _model.timerMilliseconds = value;
                          _model.timerValue = displayTime;
                          if (shouldUpdate) safeSetState(() {});
                        },
                        onEnded: () async {
                          _model.timerController.onResetTimer();

                          _model.showWaveform = false;
                          _model.showTextInput = true;
                          safeSetState(() {});
                        },
                        textAlign: TextAlign.start,
                        style:
                            FlutterFlowTheme.of(context).headlineSmall.override(
                                  fontFamily: 'Outfit',
                                  color: const Color(0x00FFFFFF),
                                  fontSize: 2.0,
                                  letterSpacing: 0.0,
                                ),
                      ),
                  ],
                ),
              ),
            ),
            if (_model.showTextInput && !_model.isRecording && !_model.isTranscribing && !_model.showWaveform)
              Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 24.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _model.textInputController,
                          focusNode: _model.textInputFocusNode,
                          autofocus: false,
                          obscureText: false,
                          decoration: InputDecoration(
                            isDense: true,
                            labelStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Figtree',
                                  letterSpacing: 0.0,
                                ),
                            hintText: 'Type your message...',
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Figtree',
                                  letterSpacing: 0.0,
                                ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).alternate,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).error,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                            filled: true,
                            fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                            contentPadding: const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 12.0),
                          ),
                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'Figtree',
                                letterSpacing: 0.0,
                              ),
                          maxLines: 3,
                          minLines: 1,
                          cursorColor: FlutterFlowTheme.of(context).primary,
                          validator: _model.textInputControllerValidator
                              .asValidator(context),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 0.0, 0.0),
                        child: FlutterFlowIconButton(
                          borderRadius: 24.0,
                          buttonSize: 48.0,
                          fillColor: FlutterFlowTheme.of(context).primary,
                          disabledColor: FlutterFlowTheme.of(context).alternate,
                          icon: Icon(
                            Icons.send_rounded,
                            color: Colors.white,
                            size: 24.0,
                          ),
                          onPressed: (_model.textInputController.text.trim().isEmpty)
                              ? null
                              : () async {
                                  var shouldSetState = false;
                                  
                                  // Validate settings first
                                  _model.settingsOK = await actions.validateSettings();
                                  shouldSetState = true;
                                  if (!_model.settingsOK!) {
                                    await showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (context) {
                                        return GestureDetector(
                                          onTap: () => FocusScope.of(context).unfocus(),
                                          child: Padding(
                                            padding: MediaQuery.viewInsetsOf(context),
                                            child: const SettingsWidget(),
                                          ),
                                        );
                                      },
                                    ).then((value) => safeSetState(() {}));
                                    if (shouldSetState) {
                                      safeSetState(() {});
                                    }
                                    return;
                                  }

                                  // Get the text input
                                  final textMessage = _model.textInputController.text.trim();
                                  
                                  // Clear the input field
                                  _model.textInputController.clear();
                                  
                                  // Add user message to chat history
                                  FFAppState().addToMessageHistory(MessageStruct(
                                    text: textMessage,
                                    blueBubble: true,
                                  ));
                                  safeSetState(() {});
                                  
                                  // Hide text input during processing
                                  _model.showTextInput = false;
                                  _model.isTranscribing = true;
                                  safeSetState(() {});
                                  
                                  // Wait for UI elements
                                  await Future.delayed(const Duration(milliseconds: 100));
                                  
                                  // Scroll to bottom
                                  await _model.listViewController?.animateTo(
                                    _model.listViewController!.position.maxScrollExtent,
                                    duration: const Duration(milliseconds: 100),
                                    curve: Curves.ease,
                                  );
                                  
                                  // Call webhook
                                  _model.getResponseAPICall = await GetAgentResponseCall.call(
                                    prompt: textMessage,
                                    webhookURL: FFAppState().webhookURL,
                                    webhookAuthValue: FFAppState().webhookAuthValue,
                                    sessionID: FFAppState().sessionID,
                                  );
                                  shouldSetState = true;
                                  
                                  if ((_model.getResponseAPICall?.succeeded ?? true)) {
                                    // Run TTS for webhook response
                                    _model.speechDuration = await actions.fetchSpeechAndPlay(
                                      GetAgentResponseCall.speech(
                                        (_model.getResponseAPICall?.jsonBody ?? ''),
                                      ).toString(),
                                      FFAppState().apiKey,
                                    );
                                    shouldSetState = true;
                                    
                                    // Set timer value (playback length)
                                    FFAppState().timerValue = _model.speechDuration!;
                                    safeSetState(() {});
                                    
                                    // Transcription finished
                                    _model.isTranscribing = false;
                                    // Show waveform
                                    _model.showWaveform = true;
                                    safeSetState(() {});
                                    
                                    // Wait for UI elements (timer)
                                    await Future.delayed(const Duration(milliseconds: 100));
                                    
                                    // Start timer
                                    _model.timerController.onStartTimer();
                                    
                                    // Add grey bubble to conversation
                                    FFAppState().addToMessageHistory(MessageStruct(
                                      text: GetAgentResponseCall.text(
                                        (_model.getResponseAPICall?.jsonBody ?? ''),
                                      ).toString(),
                                    ));
                                    safeSetState(() {});
                                    
                                    // Wait for UI elements
                                    await Future.delayed(const Duration(milliseconds: 100));
                                    
                                    // Scroll to bottom
                                    await _model.listViewController?.animateTo(
                                      _model.listViewController!.position.maxScrollExtent,
                                      duration: const Duration(milliseconds: 100),
                                      curve: Curves.ease,
                                    );
                                  } else {
                                    // Display error message in UI
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          (_model.getResponseAPICall?.jsonBody ?? '').toString(),
                                          style: TextStyle(
                                            color: FlutterFlowTheme.of(context).primaryText,
                                          ),
                                        ),
                                        duration: const Duration(milliseconds: 5000),
                                        backgroundColor: FlutterFlowTheme.of(context).error,
                                      ),
                                    );
                                    _model.showTextInput = true;
                                    _model.isTranscribing = false;
                                  }
                                  
                                  if (shouldSetState) {
                                    safeSetState(() {});
                                  }
                                },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
