public class RDInfo {
    private int totalFieldSize;
    private int actual_used_size;
    private Statement stm;
    private String unused_field;
    private String used_field;
    private String table;
    public RDInfo(){

    }
    public RDInfo(int totalFieldSize, int actual_used_size, Statement stm, String unused_field, String used_field, String table) {
        this.totalFieldSize = totalFieldSize;
        this.actual_used_size = actual_used_size;
        this.stm = stm;
        this.unused_field = unused_field;
        this.used_field = used_field;
        this.table = table;
    }
    public void self_print(){
        System.out.println(totalFieldSize + " " + actual_used_size + " " + unused_field + " " +table);
    }
    public void setTotalFieldSize(int totalFieldSize) {

        this.totalFieldSize = totalFieldSize;
    }

    public void setActual_used_size(int actual_used_size) {
        this.actual_used_size = actual_used_size;
    }

    public void setStm(Statement stm) {
        this.stm = stm;
    }

    public void setUnused_field(String unused_field) {
        this.unused_field = unused_field;
    }

    public void setTable(String table) {
        this.table = table;
    }

    public int getTotalFieldSize() {

        return totalFieldSize;
    }

    public int getActual_used_size() {
        return actual_used_size;
    }

    public Statement getStm() {
        return stm;
    }

    public String getUnused_field() {
        return unused_field;
    }

    public String getTable() {
        return table;
    }

    public String getUsed_field() {
        return used_field;
    }

    public void setUsed_field(String used_field) {
        this.used_field = used_field;
    }
}
