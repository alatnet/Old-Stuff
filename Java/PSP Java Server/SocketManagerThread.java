import java.net.*;
import java.io.*;

public class SocketManagerThread extends Thread{
  private boolean STOP;
  private ServerSocket SERVERSOCKET;
  private int SIZE; //TEST
  private PlayerThread[] Players;
  private GameList gameslist;
  private int numConnections;

  public Object[][] getPlayersAsArray(){
    Object[][] ret = new Object[numConnections][];

    for (int i=0;i<numConnections;i++){
      if (this.Players[i] != null){
        ret[i] = this.Players[i].getPlayer().toArray();
      }else{
        Player tmpPlayer = new Player("0.0.0.0",0000);
        tmpPlayer.setName("N\\A");
        ret[i] = tmpPlayer.toArray();
        tmpPlayer = null;
      }
    }

    return ret;
  }

  public Object[][] getGamesAsArray(){
    return gameslist.toArray();
  }

  public SocketManagerThread(int port,int numConnections){
    this.STOP = false;

    try{
      SERVERSOCKET = new ServerSocket(port);
    }catch (Exception e){
      System.out.println("SocketManagerThread.java\n (SocketManagerThread):" + e);
      System.exit(1);
    }

    Players = new PlayerThread[numConnections];
    this.numConnections = numConnections;

    for (int i=0;i<numConnections;i++){
      Players[i] = null;
    }
    
    gameslist = new GameList();
  }

  public int size(){
    /*
    int ret = 0;

    for (int i=0;i<this.numConnections;i++){
      if (this.Players[i] != null){
        ret++;
      }
    }

    return ret;
    */
    
    return this.SIZE;
  }
  
  public int sizeGames(){
    return gameslist.size();
  }
  
  public void run(){
    System.out.println("\nSocketManagerThread: " + Thread.currentThread().getId() + " :: " + Thread.currentThread().getName() + "\n");
    Socket tmpSocket=null;

    while (!this.STOP){
      try{
          tmpSocket = this.SERVERSOCKET.accept();

          if (tmpSocket != null){
            boolean Available_Spot = false;
            for (int i=0;i<this.numConnections;i++){
              if (this.Players[i] == null){
                this.Players[i] = new PlayerThread(tmpSocket); //Add to the list of connected players.
                this.Players[i].start();
                Available_Spot = true;
                this.SIZE++;
                break;
              }
            }

            if (!Available_Spot){
              PrintWriter PW = new PrintWriter(tmpSocket.getOutputStream(),true);
              PW.println("FULL");
              PW.close();
            }
          }
          tmpSocket = null;
      }catch (SocketException e){
        this.STOP = true;
        for (int i=0;i<this.numConnections;i++){
          if (this.Players[i] != null){
            this.Players[i].stop("SERVER_SHUTDOWN");
            try{
              Thread.sleep(1);
            }catch (Exception eee){
              System.out.println("SocketManagerThread.java\n (run[1]):" + eee);
              System.exit(1);
            }
          }
        }
        System.out.println("SocketManagerThread.java\n (run[2]):" + e);
        break;
      }catch (Exception e){
        for (int i=0;i<this.numConnections;i++){
          if (this.Players[i] != null){
            this.Players[i].stop("SERVER_ERROR");
            try{
              Thread.sleep(1);
            }catch (Exception ee){
              System.out.println("SocketManagerThread.java\n (run[3]):" + ee);
              System.exit(1);
            }
          }
        }
        System.out.println("SocketManagerThread.java\n (run[4]):" + e);
        System.exit(1);
      }
      try{
        Thread.sleep(1);
      }catch (Exception e){
        System.out.println("SocketManagerThread.java\n (run[5]):" + e);
        System.exit(1);
      }

      for (int i=0;i<this.numConnections;i++){
        if (this.Players[i] != null){
          if (this.Players[i].isClosed() || this.Players[i].isStoped() || this.Players[i].getState() == Thread.State.TERMINATED || !this.Players[i].isAlive()){
            this.Players[i] = null;
            this.SIZE--;
            try{
              Thread.sleep(1);
            }catch (Exception ee){
              System.out.println("SocketManagerThread.java\n (run[6]):" + ee);
              System.exit(1);
            }
          }
        }
      }
      
      if (this.STOP){
        break;
      }
    }
    
    if (this.STOP){
      System.out.println("SocketManagerThread (run[7])(STOP): Thread: " + Thread.currentThread().getId() + " :: " + Thread.currentThread().getName() + "\n");
    }
  }

  public void Stop(){
    this.STOP = true;
    
    try{
      this.SERVERSOCKET.close();
    }catch (Exception e){
      System.out.println("SocketManagerThread.java\n (Stop):" + e);
      System.exit(1);
    }

    for (int i=0;i<this.numConnections;i++){
      if (this.Players[i] != null){
        this.Players[i].stop("SERVER_SHUTDOWN");
      }
    }
  }
  
  public class PlayerThread extends Thread{
    private boolean STOP;
    private Socket SOCKET;
    private PrintWriter out;
    private BufferedReader in;
    private Player data;
    
    public PlayerThread(){
      this.STOP = true;
    }
  
    public PlayerThread(Socket SOCKET){
      this.STOP = false;
      this.SOCKET = SOCKET;

      try{
        this.out = new PrintWriter(this.SOCKET.getOutputStream(),true);
        this.in = new BufferedReader(new InputStreamReader(this.SOCKET.getInputStream()));
      }catch (Exception e){
        System.out.println("PlayerThread.java (PlayerThread):\n" + e);
        System.exit(1);
      }

      this.out.println("OK");
      this.data = new Player(this.SOCKET.getInetAddress().getHostAddress(),this.SOCKET.getPort());
    }

    public void run(){
      String LINE="";

      if (!this.STOP){
        try{
          Thread.sleep(200);
        }catch (Exception e){
          System.out.println("SocketManagerThread.java\n (run[1]):" + e);
          System.exit(1);
        }
        //System.out.println("\nPlayerThread (run[1])(" + this.data.getIP() + ":" + this.data.getPort() + " (" + this.data.getName() + ")): " + Thread.currentThread().getId() + " :: " + Thread.currentThread().getName() + "\n");

        this.out.println("REQUEST_NAME");
      }

      while ((!this.STOP) && (this.SOCKET.isConnected())){
        LINE="";
        try{
          LINE = in.readLine();
        }catch (Exception e){
          System.out.println("PlayerThread.java (run[2]):\n" + e);
          System.exit(1);
        }

        if (LINE != null){
          if (!(LINE.equals("")) || LINE.length() != 0){
            this.data.setName(LINE);
            this.out.println("CONNECTED");
            break;
          }
        }
        this.out.println("REQUEST_NAME");

        try{
          Thread.sleep(200);
        }catch (Exception e){
          System.out.println("SocketManagerThread.java\n (run[3]):" + e);
          System.exit(1);
        }
        if (this.STOP){
          break;
        }
      }

      System.out.println("\nPlayerThread (run[4])(" + this.data.getIP() + ":" + this.data.getPort() + " (" + this.data.getName() + ")): " + Thread.currentThread().getId() + " :: " + Thread.currentThread().getName() + "\n");

      LINE="";

      while ((!this.STOP) && (this.SOCKET.isConnected())){
        LINE="";
        try{
          LINE = in.readLine();
        }catch (Exception e){
          System.out.println("PlayerThread (run[5]):\n" + e);
          System.exit(1);
        }
        if (LINE!=null){
          if (LINE.equals("getLIST")){
            /*
            this.out.println("ArrayName");
            LINE="";
            try{
              LINE = in.readLine();
            }catch (Exception e){
              System.out.println("PlayerThread (run[3]):\n" + e);
              System.exit(1);
            }
            */
            this.out.println(gameslist.toLua());
          }else if (LINE.equals("newGAME")){
            String line1 = "";
            String line2 = "";
            String line3 = "";

            this.out.println("REQUEST_TITLE");
            try{
              line1 = in.readLine();
            }catch (Exception e){
              System.out.println("PlayerThread (run[6]):\n" + e);
              System.exit(1);
            }

            this.out.println("REQUEST_DETAILS");
            try{
              line2 = in.readLine();
            }catch (Exception e){
              System.out.println("PlayerThread (run[7]):\n" + e);
              System.exit(1);
            }

            this.out.println("REQUEST_PORT");
            try{
              line3 = in.readLine();
            }catch (Exception e){
              System.out.println("PlayerThread (run[8]):\n" + e);
              System.exit(1);
            }

            //TODO: add a way for multiple clients to a game.

            gameslist.addGame(this.data,line1,line2,line3);

            this.out.println("GAME_OK");
          }else if (LINE.equals("removeGAME")){
            gameslist.removeGame(this.data);
            this.out.println("GAME_OK");
          }else if (LINE.equals("connectGAME")){
            this.out.println("REQUEST_HOST");
            LINE="";
            try{
              LINE = in.readLine();
            }catch (Exception e){
              System.out.println("PlayerThread (run[9]):\n" + e);
              System.exit(1);
            }
            boolean success = gameslist.connectGame(LINE,this.data);

            if (success){
              this.out.println("CONNECTION_OK");
            }else{
              this.out.println("CONNECTION_FAIL");
            }
          }else if (LINE.equals("disconnectGAME")){
            this.out.println("REQUEST_HOST");
            LINE="";
            try{
              LINE = in.readLine();
            }catch (Exception e){
              System.out.println("PlayerThread (run[10]):\n" + e);
              System.exit(1);
            }
            gameslist.disconnectGame(LINE,this.data);
            this.out.println("DISCONNECTED");
          }else if (LINE.equals("LEAVE")){
            this.STOP = true;
            try{
              this.out.close();
              this.in.close();
              this.SOCKET.close();
            }catch (Exception e){
              System.out.println("PlayerThread (run[11]):\n" + e);
              System.exit(1);
            }
            break;
          }
        }

        try{
          Thread.sleep(200);
        }catch (Exception e){
          System.out.println("PlayerThread (run[12]\n):" + e);
          System.exit(1);
        }
        if (this.STOP){
          break;
        }
      }



      if (this.STOP){
        System.out.println("PlayerThread (run[13])(STOP): Thread: " + Thread.currentThread().getId() + " :: " + Thread.currentThread().getName() + "\n");
      }
      SIZE--;
    }

    public void stop(String msg){
      this.out.println(msg);
      this.STOP = true;
      try{
        this.out.close();
        this.in.close();
        this.SOCKET.close();
      }catch (Exception e){
        System.out.println("PlayerThread.java (stop):\n" + e);
        System.exit(1);
      }
    }
    
    public boolean isStoped(){
      return this.STOP;
    }
    
    public boolean isClosed(){
      return this.SOCKET.isClosed();
    }

    public Player getPlayer(){
      return data;
    }
  }
}