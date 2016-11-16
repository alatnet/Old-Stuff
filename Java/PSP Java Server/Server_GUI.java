import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class Server_GUI extends JFrame implements WindowListener{
  private INIFile ServerSettings;
  private SocketManagerThread SMT;
  private Server_GUI_Thread SGT;

  private int ServerPort;
  private int numConnections;

  private JLabel Labels[][];
  
  private SYSTEMTRAY SysTray;
  
  private Image ICONIMG;

  public Server_GUI(){
    this("PSP Java Server");
  }

  public Server_GUI(String TITLE){
    super(TITLE);  //"Ultimate Battle RPG Server"
    
    this.ICONIMG = Toolkit.getDefaultToolkit().getImage("Icon.png");
    
    this.SysTray = new SYSTEMTRAY(this.ICONIMG,TITLE,new ACTIONLISTENER(),this);
    setIconImage(this.ICONIMG);

    this.ServerSettings = new INIFile("Server.ini");
    this.ServerSettings.read();

    this.ServerPort = Integer.parseInt(this.ServerSettings.getEntryVal("Network","usePort"));
    this.numConnections = Integer.parseInt(this.ServerSettings.getEntryVal("Network","maxConnections"));

    this.SMT = new SocketManagerThread(this.ServerPort,this.numConnections);
    this.SGT = new Server_GUI_Thread();

    //create components start
    Labels = new JLabel[4][2];

    Labels[0][0] = new JLabel(" Server status: ");
    Labels[0][1] = new JLabel(" Inactive");

    Labels[1][0] = new JLabel(" Server uptime: ");
    Labels[1][1] = new JLabel(" 00:00:00:00");

    Labels[2][0] = new JLabel(" Current number of players: ");
    Labels[2][1] = new JLabel(" 0/0");

    Labels[3][0] = new JLabel(" Current number of games: ");
    Labels[3][1] = new JLabel(" 0");
    //create components end

    //add components start
    JPanel mainpanel = new JPanel(new GridLayout(4,2),true);

    for (int y=0;y<Labels.length;y++){
      for (int x=0;x<2;x++){
        mainpanel.add(Labels[y][x]);
      }
    }
    //add components end

    this.getContentPane().add(mainpanel, BorderLayout.CENTER);

    this.setJMenuBar(new Server_GUI_MenuBar());
    this.setDefaultCloseOperation(JFrame.DO_NOTHING_ON_CLOSE);
    this.addWindowListener(this);
    this.pack();
    this.setVisible(true);
    this.SMT.start();
    this.SGT.start();
    this.SysTray.Display();
  }
  
  public void CloseServer(){
    //setVisible(false);
    this.SGT.Stop();
    
    if (this.SMT != null){
      this.SMT.Stop();
    }

    this.ServerSettings.write();
    System.exit(0);
  }

  public void ShutdownServer(){
    if (this.SMT != null){
      this.SMT.Stop();
      this.SMT = null;
      if (SysTray.isVisible()){
        SysTray.DispMsgStop();
      }
    }
  }

  public void StartupServer(){
    if (this.SMT == null){
      this.SMT = new SocketManagerThread(this.ServerPort,this.numConnections);
      this.SMT.start();
      if (SysTray.isVisible()){
        SysTray.DispMsgStart();
      }
    }
  }

  public void windowClosing(WindowEvent event){
    //this.CloseServer();
    this.setVisible(false);
  }

  public void windowClosed(WindowEvent e){}

  public void windowOpened(WindowEvent e){
    //this.setVisible(true);
  }
  public void windowIconified(WindowEvent e){}
  public void windowDeiconified(WindowEvent e){}
  public void windowActivated(WindowEvent e){}
  public void windowDeactivated(WindowEvent e){}
  
  public void PlayersFrame(){
    Object[][] data;

    if (this.SMT != null){
      data = this.SMT.getPlayersAsArray();
    }else{
      data = null;
    }

    JPanel panel = new JPanel(new GridLayout(1,1));

    if (data != null){
      String[] columnNames = {"Name","IP","Port"};

      JTable table = new JTable(data, columnNames);
      JScrollPane scrollPane = new JScrollPane(table);
      panel.add(scrollPane);
    }else{
      JLabel label = new JLabel(" No Players Connected. ");
      panel.add(label);
    }

    JFrame frame = new JFrame("Players");
    frame.setLayout(new GridLayout(1,1));
    
    frame.getContentPane().add(panel, BorderLayout.CENTER);
    frame.pack();
    //frame.setResizable(false);
    frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
    frame.setVisible(true);
  }
  
  public void GamesFrame(){
    Object[][] data;

    if (this.SMT != null){
      data = this.SMT.getGamesAsArray();
    }else{
      data = null;
    }
    JPanel panel = new JPanel(new GridLayout(1,1));

    if (data != null){
      String[] columnNames = {"Title","Details","Host","Client","Port","Locked"};

      JTable table = new JTable(data, columnNames);
      JScrollPane scrollPane = new JScrollPane(table);
      panel.add(scrollPane);
    }else{
      JLabel label = new JLabel(" No games hosted. ");
      panel.add(label);
    }

    JFrame frame = new JFrame("Games");
    frame.setLayout(new GridLayout(1,1));

    frame.getContentPane().add(panel, BorderLayout.CENTER);
    frame.pack();
    //frame.setResizable(false);
    frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
    frame.setVisible(true);
  }

  public class ACTIONLISTENER implements ActionListener{
    public void actionPerformed(ActionEvent event){
      String ACTION = event.getActionCommand();

      if (ACTION.equals("")){
      }else if (ACTION.equals("Start")){
        StartupServer();
      }else if (ACTION.equals("Stop")){
        ShutdownServer();
      }else if (ACTION.equals("Exit")){
        CloseServer();
      }else if (ACTION.equals("Quit")){
        CloseServer();
      }else if (ACTION.equals("Games")){
        GamesFrame();
      }else if (ACTION.equals("Players")){
        PlayersFrame();
      }else if (ACTION.equals("Prefs")){
      }else if (ACTION.equals("PrefsW")){
      }
    }
  }

  public class Server_GUI_MenuBar extends JMenuBar{
    private ACTIONLISTENER AL;
    public Server_GUI_MenuBar(){
      super();

      this.AL = new ACTIONLISTENER();

      //File Menu Start
      JMenu menu = new JMenu("File");
      menu.setMnemonic(KeyEvent.VK_F);
      //Filemenu.getAccessibleContext().setAccessibleDescription("The only menu in this program that has menu items");
      add(menu);   //setActionCommand(String); addActionListener(ActionListener); addItemListener(ItemListener);

      JMenuItem menuItem = new JMenuItem("Startup",KeyEvent.VK_S);
      menuItem.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_S, ActionEvent.ALT_MASK));
      menuItem.getAccessibleContext().setAccessibleDescription("Startup the server.");
      menuItem.setActionCommand("Start");
      menuItem.addActionListener(AL);
      menu.add(menuItem);

      menuItem = new JMenuItem("Shutdown",KeyEvent.VK_H);
      menuItem.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_H, ActionEvent.ALT_MASK));
      menuItem.getAccessibleContext().setAccessibleDescription("Shutdown the server.");
      menuItem.setActionCommand("Stop");
      menuItem.addActionListener(AL);
      menu.add(menuItem);

      menuItem = new JMenuItem("Quit",KeyEvent.VK_Q);
      menuItem.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_Q, ActionEvent.ALT_MASK));
      menuItem.getAccessibleContext().setAccessibleDescription("Shutdown and exit the server.");
      menuItem.setActionCommand("Quit");
      menuItem.addActionListener(AL);
      menu.add(menuItem);
      //File Menu End
      
      //View Menu Start
      menu = new JMenu("View");
      menu.setMnemonic(KeyEvent.VK_V);
      //Filemenu.getAccessibleContext().setAccessibleDescription("The only menu in this program that has menu items");
      add(menu);   //setActionCommand(String); addActionListener(ActionListener); addItemListener(ItemListener);

      menuItem = new JMenuItem("Games",KeyEvent.VK_G);
      menuItem.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_G, ActionEvent.ALT_MASK));
      menuItem.getAccessibleContext().setAccessibleDescription("List current games hosted.");
      menuItem.setActionCommand("Games");
      menuItem.addActionListener(AL);
      menu.add(menuItem);

      menuItem = new JMenuItem("Players",KeyEvent.VK_P);
      menuItem.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_P, ActionEvent.ALT_MASK));
      menuItem.getAccessibleContext().setAccessibleDescription("List current players connected.");
      menuItem.setActionCommand("Players");
      menuItem.addActionListener(AL);
      menu.add(menuItem);
      //View Menu End

      //Options Menu Start
      menu = new JMenu("Options");
      menu.setMnemonic(KeyEvent.VK_O);
      //Filemenu.getAccessibleContext().setAccessibleDescription("The only menu in this program that has menu items");
      add(menu);   //setActionCommand(String); addActionListener(ActionListener); addItemListener(ItemListener);

      menuItem = new JMenuItem("Prefs",KeyEvent.VK_R);
      menuItem.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_R, ActionEvent.ALT_MASK));
      menuItem.getAccessibleContext().setAccessibleDescription("Edit server preferences.\nNote: Server reset may be needed for\nsome options to be enabled/disabled.");
      menuItem.setActionCommand("Prefs");
      menuItem.addActionListener(AL);
      menu.add(menuItem);
      
      menuItem = new JMenuItem("Prefs Wizard",KeyEvent.VK_W);
      menuItem.setAccelerator(KeyStroke.getKeyStroke(KeyEvent.VK_R, ActionEvent.ALT_MASK));
      menuItem.getAccessibleContext().setAccessibleDescription("Edit server preferences.\nNote: Server reset may be needed for\nsome options to be enabled/disabled.");
      menuItem.setActionCommand("PrefsW");
      menuItem.addActionListener(AL);
      menu.add(menuItem);
      //Options Menu End
    }
  }
  
  public class Server_Timer_Actionlistener implements ActionListener{
    private int MS = 0;
    public void actionPerformed(ActionEvent event){
      MS++;
    }

    public int getTime(){
      return this.MS;
    }
    
    public void resetTime(){
      this.MS = 0;
    }

    public void resetTime(int Offset){
      this.MS = Offset;
    }
  }

  public class Server_GUI_Thread extends Thread{
    private boolean STOP;
    private int seconds = 0;
    private int minutes = 0;
    private int hours = 0;
    private int days = 0;

    private Server_Timer_Actionlistener STAL;
    private Timer timer;
    
    private String TimeStr;

    public Server_GUI_Thread(){
      this.STOP = false;
      STAL = new Server_Timer_Actionlistener();
      timer = new Timer(1000,STAL);
      timer.setRepeats(true);
      timer.start();
    }

    public void run(){
      System.out.println("\nServer_GUI_Thread: " + Thread.currentThread().getId() + " :: " + Thread.currentThread().getName() + "\n");
      while (!this.STOP){

        this.TimeStr = " " + this.days + ":" + this.hours + ":";
        if (this.minutes < 10){
          this.TimeStr += "0" + this.minutes + ":";
        }else{
          this.TimeStr += this.minutes + ":";
        }

        if (this.seconds < 10){
          this.TimeStr += "0" + this.seconds;
        }else{
          this.TimeStr += this.seconds;
        }
        
        SysTray.UpdateTime(this.days,this.hours,this.minutes,this.seconds);

        if (SMT != null){
          Labels[0][1].setText(" Active"); //status
          Labels[2][1].setText(" " + SMT.size() + "/" + numConnections); //players
          Labels[3][1].setText(" " + SMT.sizeGames()); //games
          Labels[1][1].setText(this.TimeStr); //uptime
        }else{
          Labels[0][1].setText(" Inactive"); //status
          Labels[2][1].setText(" 0/0"); //players
          Labels[3][1].setText(" 0"); //games
          Labels[1][1].setText(" 00:00:00:00"); //uptime
        }

        if (SMT != null){
          if (this.STAL.getTime() >= 1){
            this.seconds++;
            this.STAL.resetTime();
          }
          if (this.seconds >= 60){
            this.minutes++;
            this.seconds = 0;
          }
          if (this.minutes >= 60){
            this.hours++;
            this.minutes = 0;
          }
          if (this.hours >= 24){
            this.days++;
            this.hours = 0;
          }
        }else{
          this.STAL.resetTime();
          this.seconds = 0;
          this.minutes = 0;
          this.hours = 0;
          this.days = 0;
        }

        try{
          Thread.sleep(1);
        }catch (Exception e){
          System.out.println("SocketManagerThread.java\n (run):" + e);
          System.exit(1);
        }
      }
    }

    public void Stop(){
      this.STOP = true;
    }
  }

  public class SYSTEMTRAY implements MouseListener{
    private SystemTray tray;
    private TrayIcon trayIcon;
    private boolean SUPPORTED;
    private boolean VISIBLE;
    private String TITLE;
    private MenuItem ServerUptime;
    private JFrame FRAME;
  
    public SYSTEMTRAY(Image img,String title,ActionListener AL,JFrame frame){
      this.TITLE = title;
      this.VISIBLE = false;
      this.FRAME = frame;
      if (SystemTray.isSupported()){
        this.SUPPORTED = true;
        this.tray = SystemTray.getSystemTray();
      }
  
      PopupMenu popup = new PopupMenu();
      
      MenuItem MNUTITLE = new MenuItem(title);
      MNUTITLE.setEnabled(false);

      this.ServerUptime = new MenuItem("00:00:00:00");
      this.ServerUptime.setEnabled(false);

      MenuItem start = new MenuItem("Startup");
      start.addActionListener(AL);
      start.setActionCommand("Start");
  
      MenuItem stop = new MenuItem("Shutdown");
      stop.addActionListener(AL);
      stop.setActionCommand("Stop");
  
      MenuItem exit = new MenuItem("Exit");
      exit.addActionListener(AL);
      exit.setActionCommand("Exit");

      popup.add(MNUTITLE);
      popup.add(ServerUptime);
      popup.add(start);
      popup.add(stop);
      popup.add(exit);
  
      this.trayIcon = new TrayIcon(img,title,popup);
  
      this.trayIcon.setImageAutoSize(true);
      this.trayIcon.addMouseListener(this);
    }

    public void UpdateTime(int day,int hour,int min,int sec){
      String TimeStr = "Uptime: " + day + ":" + hour + ":";
      
      if (min < 0){
        TimeStr+= "0" + min + ":";
      }else{
        TimeStr+= min + ":";
      }
      
      if (sec < 0){
        TimeStr+= "0" + sec;
      }else{
        TimeStr+= sec;
      }
  
      this.ServerUptime.setLabel(TimeStr);
      //this.trayIcon.setTooltip("Server Uptime: " + TimeStr);
    }

    public void mouseClicked(MouseEvent e) {
      int BUTTON = e.getButton();
      
      if (BUTTON == MouseEvent.BUTTON1){
        this.FRAME.setVisible(true);
      }
    }

    public void mouseEntered(MouseEvent e) {}

    public void mouseExited(MouseEvent e) {}

    public void mousePressed(MouseEvent e) {}

    public void mouseReleased(MouseEvent e) {}

    public void Display(){
      if (!this.VISIBLE){
        try {
          this.tray.add(this.trayIcon);
          this.VISIBLE = true;
        }catch (AWTException e){
          System.out.println("SystemTray add error: " + e);
        }
      }
    }
  
    public void Hide(){
      if (this.VISIBLE){
        this.tray.remove(this.trayIcon);
        this.VISIBLE = false;
      }
    }
    
    public boolean isVisible(){
      return this.VISIBLE;
    }
  
    public void ChangeImg(Image img){
      this.trayIcon.setImage(img);
    }

    public void DispMsgStart(){
      this.trayIcon.displayMessage(this.TITLE,"Starting Up.",TrayIcon.MessageType.INFO);
    }
  
    public void DispMsgStop(){
      this.trayIcon.displayMessage(this.TITLE,"Shuting Down.",TrayIcon.MessageType.INFO);
    }
  }
}