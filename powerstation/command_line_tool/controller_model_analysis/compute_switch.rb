$tempfile_print_forward_edges=false
$tempfile_print_backward_edges=true
$tempfile_print_control_edges=false

$compute_assignment_source=true

$compute_card=true

#loop iteration affected by DB or not, has loop carry dep or not
$compute_loopdetail=false

#check if a query result is stored into a program variable or not
$compute_materialized_result=false

#check query dependency in terms of control flow
$compute_querydep_controlflow=false

$compute_querychain_length=false

#check how many queries are on the same data structure
$compute_partial_overlap=true

#whether a view lives in closure or not, I guess this data is kind of useless...
$compute_view_stat=false

#how many loop has loop-carry dep
$compute_loop_stat=true

#input sensitivity analysis: how many input affects branch
$compute_input_stat=false

$compute_select_condition=false

$compute_order_stat=false

$compute_field_order_stat=true

$compute_redundant_usage=true

$compute_redundant_table_usage=true

$compute_branch_queries=false

$compute_physical_volatile_store=true

#the diff between longest and shortest path 
$compute_single_path=false

$print_table_detail=false

$print_querydep_graph=false
$graph_print_control_edge = false


