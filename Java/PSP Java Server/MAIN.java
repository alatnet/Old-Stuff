public class MAIN{
  public static void main(String[] args){
    if (args.length == 0){
      new Server_GUI();
    }else{
      new Server_GUI(args[0]);
    }
  }
}