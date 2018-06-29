import java.util.List;
import java.util.ArrayList;
public class CSInfo {

    public String getExpression() {
        return expression;
    }

    public List<Statement> getExprs() {
        return exprs;
    }

    private String expression;
    private List<Statement> exprs;

    public CSInfo(){
        this.expression = "";
        exprs = new ArrayList<Statement>();
    }

    public CSInfo(String expression, List<Statement> exprs){
        this.expression = expression;
        this.exprs = exprs;
    }


}
