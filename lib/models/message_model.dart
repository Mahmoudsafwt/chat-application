class MessageModel{
  final String message;
  final String email;
  MessageModel(this.message,this.email);
  factory MessageModel.fromJason(jasonData){
    return MessageModel(jasonData['message'],jasonData['email']);
  }
}