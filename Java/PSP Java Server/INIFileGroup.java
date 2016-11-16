import java.util.ArrayList;

public class INIFileGroup{
  private ArrayList<INIFileEntry> Entries;
  private String name;

  public INIFileGroup(String name){
    this.name = name;
    this.Entries = new ArrayList<INIFileEntry>();
  }

  //misc methods start
  public int size(){
    return this.Entries.size();
  }
  //misc methods end

  //get methods start
  public String getEntryVal(String name){
    for (int i=0;i<this.Entries.size();i++){
      if (this.Entries.get(i).getName().equals(name)){
        return this.Entries.get(i).getVal();
      }
    }
    return "";
  }
  
  public String getName(){
    return this.name;
  }

  public INIFileEntry[] getEntries(){
    return (INIFileEntry[])this.Entries.toArray();
  }
  //get methods end

  //set methods start
  public void setEntryVal(String name,String val){
    for (int i=0;i<this.Entries.size();i++){
      if (this.Entries.get(i).getName().equals(name)){
        this.Entries.get(i).setVal(val);
        break;
      }
    }
  }
  
  public void setEntryVal(INIFileEntry entry){
    for (int i=0;i<this.Entries.size();i++){
      if (this.Entries.get(i).getName().equals(entry.getName())){
        this.Entries.set(i,entry);
        break;
      }
    }
  }
  //set methods end
  
  //add methods start
  public void addEntry(String name,String val){
    this.Entries.add(new INIFileEntry(name,val));
  }

  public void addEntry(String name,String val,String info){
    this.Entries.add(new INIFileEntry(name,val,info));
  }

  public void addEntry(String name){
    this.Entries.add(new INIFileEntry(name));
  }
  
  public void addEntry(INIFileEntry entry){
    this.Entries.add(entry);
  }
  //add methods end

  //remove methods start
  public void removeEntry(String name){
    for (int i=0;i<this.Entries.size();i++){
      if (this.Entries.get(i).getName().equals(name)){
        this.Entries.remove(i);
        break;
      }
    }
  }
  //remove methods end
  
  public String toString(){
    String ret = "";

    ret += "[" + this.name + "]\n";

    for (int i=0;i<this.Entries.size();i++){
      ret += this.Entries.get(i).toString() + "\n";
    }
    
    ret += "\n";

    return ret;
  }
}