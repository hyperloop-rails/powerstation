public class Statement {

    private int loc;
    private String filename;

    public Statement(){
        this.loc = -1;
        this.filename = "";
    }

    public Statement(int loc, String fname){
        this.loc = loc;
        this.filename = fname;
    }

    public int getStatement(){
        return this.loc;
    }

    public void setStatement(int tstate){
        this.loc = tstate;
    }

    public String getFilename(){
        return this.filename;
    }

    public void setFilename(String fname2){
        this.filename = fname2;
    }
}
