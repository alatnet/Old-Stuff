import java.net.*;

public class Player{
  String IP;
  private int PORT;
  private String NAME;

  public Player(String IP,int PORT){
    this.IP = IP;
    this.PORT = PORT;
    this.NAME = "";
  }

  public int getPort(){
    return this.PORT;
  }

  public String getIP(){
    return this.IP;
  }

  public String getName(){
    return this.NAME;
  }

  public void setName(String NAME){
    this.NAME = NAME;
  }

  public String toString(){
    return this.NAME + "::" + this.IP + "::" + this.PORT;
  }
  
  public Object[] toArray(){
    Object[] ret = {this.NAME,this.IP,this.PORT};
    return ret;
  }
  
  public String toLua(){
    return "{name=\"" + this.NAME + "\",IP=\"" + this.IP + "\"}";
  }
}