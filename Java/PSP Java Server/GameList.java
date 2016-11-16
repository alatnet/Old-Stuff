import java.util.ArrayList;

public class GameList{
  private ArrayList<Game> Games;

  public GameList(){
    Games = new ArrayList<Game>();
  }

  public Game[] getGames(){
    return (Game[])this.Games.toArray();
  }
  
  public int size(){
    return this.Games.size();
  }
  
  public void addGame(Player host,String title,String details,String port){
    this.Games.add(new Game(host,title,details,port));
  }
  
  public void removeGame(Player host){
    for (int i=0;i<Games.size();i++){
      if (Games.get(i).getHost().getName().equals(host.getName())){
        Games.remove(i);
        break;
      }
    }
  }

  public boolean connectGame(String host,Player client){
    for (int i=0;i<Games.size();i++){
      if (Games.get(i).getHost().getName().equals(host)){
        return Games.get(i).setClient(client);
      }
    }
    
    return false;
  }

  public void disconnectGame(String host,Player client){
    for (int i=0;i<Games.size();i++){
      if (Games.get(i).getHost().getName().equals(host)){
        if (Games.get(i).getClient().getName().equals(client.getName())){
          Games.get(i).removeClient();
        }
      }
    }
  }

  public Object[][] toArray(){
    Object[][] ret = new Object[Games.size()][];
    
    for (int i=0;i<Games.size();i++){
      ret[i] = Games.get(i).toArray();
    }
    
    return ret;       
  }
  
  public String toLua(){
    String ret = "return {";

    for (int i=0;i<Games.size();i++){
      ret += Games.get(i).toLua();
    }

    ret += "}";

    return ret;
  }
}