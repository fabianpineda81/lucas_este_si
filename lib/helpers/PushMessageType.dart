abstract class PushMessageType {
  static String get invite => 'INVITE';
  static String get inviteConfirmation => 'INVITE CONFIRMATION';
  static String get inviteRejected => 'INVITE REJECTED';

  static String get say => 'SAY';
  static String get quiz => 'QUIZ';
  static String get answerQuiz => 'ANSWER QUIZ';
  


  static String get tryConnectingToStartPoint => 'TRY CONNECTING TO START POINT';
  static String get tryConnectingToEndPoint => 'TRY CONNECTING TO END POINT';
  static String get connectionEstablishedToStartPoint => 'CONNECTION ESTABLISHED TO START POINT';
  static String get connectionEstablishedToEndPoint => 'CONNECTION ESTABLISHED TO END POINT';
  static String get communicationFailed => 'CONNECTION FAILED';
  
  
  // static String get requestObjectList => 'REQUEST OBJECT LIST';
  // static String get objectList => 'OBJECT LIST';
  // static String get requestObjects => 'REQUEST OBJECTS';
  // static String get objectChunk => 'OBJECT CHUNK';

  // static String get requestConnection => 'REQUEST CONNECTION';
  // static String get acceptConnection => 'ACCEPT CONNECTION';
  // static String get connectionAccepted => 'CONNECTION ACCEPTED';
  
  
}