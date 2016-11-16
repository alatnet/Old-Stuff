import java.util.*;
import java.io.*;

public class INIFile{
  private ArrayList<INIFileGroup> Groups;
  private String filename;

  public INIFile(String filename){
    this.filename = filename;
    this.Groups = new ArrayList<INIFileGroup>();
  }
  
  public void read(){
    BufferedReader BR = null;

    try{
      BR = new BufferedReader(new FileReader(this.filename));
    }catch (Exception e){
      System.out.println("INIFile.java (read[1]):\n" + e);
      System.exit(1);
    }

    String LINE = "";
    String GROUP_NAME = "";
    String VARIABLE = "";
    String INFO = "";

    INIFileEntry tmpEntry = null;

    Scanner FileData;

    while (LINE!=null){
      try{
        LINE = BR.readLine();
      }catch (Exception e){
        System.out.println("INIFile.java (read[2]):\n" + e);
      }
      
      if (LINE == null){
        break;
      }

      if (LINE.length() != 0){
        if (LINE.charAt(0) == '['){
          GROUP_NAME=LINE.substring(1,LINE.length()-1);
          this.addGroup(GROUP_NAME);
        }else{
          if (LINE.charAt(0) != ';' && LINE.charAt(0) != '#'){
            FileData = new Scanner(LINE);
            FileData.useDelimiter("=");
            while (FileData.hasNext()){
              VARIABLE = FileData.next();
              if (FileData.hasNext()){
                if (INFO.equals("")){
                  this.addEntry(GROUP_NAME,VARIABLE,FileData.next());
                }else{
                  this.addEntry(GROUP_NAME,VARIABLE,FileData.next(),INFO);
                  INFO="";
                }
                break;
              }else{
                if (INFO.equals("")){
                  this.addEntry(GROUP_NAME,VARIABLE);
                }else{
                  tmpEntry = new INIFileEntry(VARIABLE);
                  tmpEntry.setInfo(INFO);
                  this.addEntry(GROUP_NAME,tmpEntry);
                  INFO="";
                  tmpEntry = null;
                }
                break;
              }
            }
          }else if (LINE.charAt(0) == ';' && LINE.charAt(0) == '#'){
            INFO+=LINE + "\n";
          }else{
            for (int i=0;i<LINE.length();i++){
              if (LINE.charAt(i) == ';' || LINE.charAt(i) == '#'){
                INFO+=LINE + "\n";
                break;
              }else if (LINE.charAt(i) == '['){
                GROUP_NAME=LINE.substring(i+1,LINE.length()-1);
                this.addGroup(GROUP_NAME);
              }else{
                LINE = LINE.substring(i+1);
                FileData = new Scanner(LINE);
                FileData.useDelimiter("=");
                while (FileData.hasNext()){
                  VARIABLE = FileData.next();
                  if (FileData.hasNext()){
                    if (INFO.equals("")){
                      this.addEntry(GROUP_NAME,VARIABLE,FileData.next());
                    }else{
                      this.addEntry(GROUP_NAME,VARIABLE,FileData.next(),INFO);
                      INFO="";
                    }
                    break;
                  }else{
                    if (INFO.equals("")){
                      this.addEntry(GROUP_NAME,VARIABLE);
                    }else{
                      tmpEntry = new INIFileEntry(VARIABLE);
                      tmpEntry.setInfo(INFO);
                      this.addEntry(GROUP_NAME,tmpEntry);
                      INFO="";
                      tmpEntry = null;
                    }
                    break;
                  }
                }
              }
            }
          }
        }
      }
    }

    try{
      BR.close();
    }catch (Exception e){
      System.out.println("INIFile.java (read[3]):\n" + e);
      System.exit(1);
    }
  }

  public void write(){
    PrintWriter PW = null;
    try{
      PW = new PrintWriter(new BufferedWriter(new FileWriter(this.filename)));
    }catch (Exception e){
      System.out.println("INIFile.java (write[1]):\n" + e);
      System.exit(1);
    }
    PW.print(this.getDataAsString());
    try{
      PW.close();
    }catch (Exception e){
      System.out.println("INIFile.java (write[2]):\n" + e);
      System.exit(1);
    }
  }
  
  //misc methods start
  public int sizeGroups(){
    return Groups.size();
  }
  
  public int sizeGroups(String groupname){
    for (int i=0;i<this.Groups.size();i++){
      if (this.Groups.get(i).getName().equals(groupname)){
        return this.Groups.get(i).size();
      }
    }

    return -1;
  }

  public int size(){
    int ret=0;

    for (int i=0;i<this.Groups.size();i++){
      ret+=this.Groups.get(i).size();
    }

    return ret;
  }
  //misc methods end

  //get methods start
  public String getEntryVal(String groupname,String entryname){
    for (int i=0;i<this.Groups.size();i++){
      if (this.Groups.get(i).getName().equals(groupname)){
        return this.Groups.get(i).getEntryVal(entryname);
      }
    }
    
    return "";
  }
  
  public String getDataAsString(){
    String ret = "";
    
    for (int i=0;i<this.Groups.size();i++){
      ret += this.Groups.get(i).toString();
    }
    
    return ret;
  }
  
  public INIFileGroup getGroup(String groupname){
    for (int i=0;i<this.Groups.size();i++){
      if (this.Groups.get(i).getName().equals(groupname)){
        return this.Groups.get(i);
      }
    }
    
    return null;
  }
  
  public INIFileGroup[] getGroups(){
    return (INIFileGroup[])this.Groups.toArray();
  }
  //get methods end
  
  //set methods start
  public void setEntryVal(String groupname,String entryname,String value){
    for (int i=0;i<this.Groups.size();i++){
      if (this.Groups.get(i).getName().equals(groupname)){
        this.Groups.get(i).setEntryVal(entryname,value);
        break;
      }
    }
  }
  
  public void setEntryVal(String groupname,INIFileEntry entry){
    for (int i=0;i<this.Groups.size();i++){
      if (this.Groups.get(i).getName().equals(groupname)){
        this.Groups.get(i).setEntryVal(entry);
        break;
      }
    }
  }
  //set methods end
  
  //add methods start
  public void addGroup(String name){
    //System.out.println("addGroup(String name): " + name);
    this.Groups.add(new INIFileGroup(name));
  }

  public void addEntry(String groupname,String entryname,String val){
    for (int i=0;i<this.Groups.size();i++){
      if (this.Groups.get(i).getName().equals(groupname)){
        this.Groups.get(i).addEntry(entryname,val);
        //System.out.println("addEntry(String groupname,String entryname,String val): " + groupname + "," + entryname + "," + val);
        break;
      }
    }
  }
  
  public void addEntry(String groupname,String entryname,String val,String info){
    for (int i=0;i<this.Groups.size();i++){
      if (this.Groups.get(i).getName().equals(groupname)){
        this.Groups.get(i).addEntry(entryname,val,info);
        //System.out.println("addEntry(String groupname,String entryname,String val,String info): " + groupname + "," + entryname + "," + val + "\nInfo:\n" + info);
        break;
      }
    }
  }

  public void addEntry(String groupname,String entryname){
    for (int i=0;i<this.Groups.size();i++){
      if (this.Groups.get(i).getName().equals(groupname)){
        this.Groups.get(i).addEntry(entryname);
        //System.out.println("addEntry(String groupname,String entryname): " + groupname + "," + entryname);
        break;
      }
    }
  }
  
  public void addEntry(String groupname,INIFileEntry entry){
    for (int i=0;i<this.Groups.size();i++){
      if (this.Groups.get(i).getName().equals(groupname)){
        this.Groups.get(i).addEntry(entry);
        break;
      }
    }
  }
  //add methods end
  
  //remove methods start
  public void removeGroup(String groupname){
    for (int i=0;i<this.Groups.size();i++){
      if (this.Groups.get(i).getName().equals(groupname)){
        this.Groups.remove(i);
        break;
      }
    }
  }

  public void removeEntry(String groupname,String entryname){
    for (int i=0;i<this.Groups.size();i++){
      if (this.Groups.get(i).getName().equals(groupname)){
        this.Groups.get(i).removeEntry(entryname);
        break;
      }
    }
  }
  //remove methods end

  public String toString(){
    String ret = "";

    ret += "------------------------------------------\n";
    ret += "INI Filename: " + this.filename + "\n";
    ret += "------------------------------------------\n";

    ret += this.getDataAsString();

    ret += "------------------------------------------\n";

    return ret;
  }
}