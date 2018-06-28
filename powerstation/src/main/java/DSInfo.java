public class DSInfo {

    private int loc1;
    private int loc2;
    private String filename1;
    private String filename2;

    public DSInfo(){
        this.loc1 = -1;
        this.loc2 = -1;
        this.filename1 = "";
        this.filename2 = "";
    }

    public DSInfo(int loc1, int loc2, String filename){
        this.loc1 = loc1;
        this.loc2 = loc2;
        this.filename1 = filename;
        this.filename2 = filename;
    }

    public int getLoc1(){
        return this.loc1;
    }

    public void setLoc1(int tloc){
        this.loc1 = tloc;
    }

    public int getLoc2(){
        return this.loc2;
    }

    public void setLoc2(int tloc2){
        this.loc2 = tloc2;
    }

    public String getFilename1(){
        return this.filename1;
    }

    public void setFilename1(String fname){
        this.filename1 = fname;
    }

    public String getFilename2(){
        return this.filename2;
    }

    public void setFilename2(String fname2){
        this.filename2 = fname2;
    }
}

