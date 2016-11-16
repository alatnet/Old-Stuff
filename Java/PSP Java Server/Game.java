public class Game{
  private Player host;
  private Player client;
  private boolean locked;
  private String title;
  private String details;
  private int port;

  public Game(Player host,String title,String details,String port){
    this.host = host;
    this.client = new Player("0.0.0.0",0000);
    this.client.setName("N\\A");
    this.locked = false;
    this.title = title;
    this.details = details;
    this.port = Integer.parseInt(port);
  }

  public boolean setClient(Player client){  //TODO: add a way for multiple clients.
    if (!this.locked){
      this.client = client;
      this.locked = true;
      return true;
    }
    
    return false;
  }

  public void removeClient(){
    if (this.locked){
      this.client = new Player("0.0.0.0",0000);
      this.client.setName("N\\A");
      this.locked = false;
    }
  }

  public Player getClient(){
    return this.client;
  }

  public Player getHost(){
    return this.host;
  }

  public String getTitle(){
    return this.title;
  }

  public String getDetails(){
    return this.details;
  }

  public Object[] toArray(){
    Object[] ret = {this.title,this.details,this.host.getName(),this.client.getName(),this.port,this.locked};
    return ret;
  }
  
  public String toLua(){
    String hostData = "{name=\"" + this.host.getName() + "\",ip=\"" + this.host.getIP() + "\",port=" + this.port + "}";
    String gameData = "{title=\"" + this.title + "\",details=\"" + this.details + "\",locked=" + this.locked + "}";
    return "{" + hostData + "," + gameData + "},";
  }
}