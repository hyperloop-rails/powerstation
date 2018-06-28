import javafx.application.Application;
import javafx.geometry.Insets;
import javafx.scene.Scene;
import javafx.scene.control.TreeItem;
import javafx.scene.control.TreeView;
import javafx.scene.layout.StackPane;
import javafx.stage.Stage;

import javax.swing.*;
import java.awt.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Set;

public class ChoiceMenu extends Application {

    private HashMap<String, ArrayList<Integer>> errors;

    public ChoiceMenu(HashMap<String, ArrayList<Integer>> errors){
        this.errors = errors;

    }

    public void start(Stage stage){
        //First, get entries out of errors set
        //then, make root items out of keys
        //for each integer in a list corresponding to a string,
        //convert it to a string, and make a new item under the root
        //with the name of the integer
        //Root Items
        ArrayList<TreeItem<String>> rootItems = new ArrayList<>();
        TreeItem<String> theRoot = new TreeItem<>("ROOT");
        //HashMap<TreeItem<String>, ArrayList<TreeItem<String>>> treeItemmap = new HashMap<>();

        for (HashMap.Entry<String, ArrayList<Integer>> entry : this.errors.entrySet()){
            //Create roots: inefficient expressions
            TreeItem<String> rootItem = new TreeItem<String>(entry.getKey());
            rootItem.setExpanded(true); //for now, just expand the entire tree

            for (int i = 0; i < entry.getValue().size(); i++){
                String intstr = Integer.toString(entry.getValue().get(i));
                TreeItem<String> item1 = new TreeItem<String>(intstr);
                //Add child to root: line numbers
                rootItem.getChildren().add(item1);
            }
            rootItems.add(rootItem);

        }

        //Add to root
        for (int j = 0; j < rootItems.size(); j++){
            theRoot.getChildren().add(rootItems.get(j));
        }

        TreeView<String> tree = new TreeView<String>(theRoot);

        //Hide the root
        tree.setShowRoot(true);

        StackPane root = new StackPane();
        root.setPadding(new Insets(5));
        root.getChildren().add(tree);

        stage.setTitle("Errors");
        stage.setScene(new Scene(root, 300, 250));
        stage.show();




    }

    public static void runApp(String[] args){
        launch(ChoiceMenu.class, args);
    }
}
