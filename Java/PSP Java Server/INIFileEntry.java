public class INIFileEntry{
  private String name;
  private String value;
  private String info;

  public INIFileEntry(String name){
    this.name = name;
    this.value = "";
    this.info = "";
  }

  public INIFileEntry(String name,String value){
    this.name = name;
    this.value = value;
    this.info = "";
  }

  public INIFileEntry(String name,String value,String info){
    this.name = name;
    this.value = value;
    this.info = info;
  }

  public String getName(){
    return this.name;
  }
  
  public String getVal(){
    return this.value;
  }
  
  public String getInfo(){
    return this.info;
  }

  public void setVal(String value){
    this.value = value;
  }
  
  public void setInfo(String info){
    this.info = info;
  }
  
  public String toString(){
    String ret = "";
    
    ret += this.info;

    ret += this.name + "=" + this.value + "\n";
    return ret;
  }
}