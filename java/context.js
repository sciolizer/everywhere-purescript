var MyJavaClass = Java.type('Main');
window = {
  context: {
    display: MyJavaClass.display,
    onInput: MyJavaClass.onInput
  }
};
