<?php
class AccEntryDetails{
 
    // database connection and table name
    private $conn;
    private $table_ref = "acc_voucher_ref";
    private $table_vchr_entry = "acc_voucher_entry";
    private $table_ldgr_entry = "acc_ledger_entry";
    private $table_grp_entry = "acc_group_entry";
    private $table_cc_entry = "acc_cc_entry";
    private $table_school = "school_info";
	
    // object properties
    public $id;
	public $school_id;
    public $amount;
    public $ledger_type;
    public $students_ledger;
    public $effective_ledger;
    public $due_detail_entry;
    public $session_year_id;
    public $server_date_time;
    public $last_detail_id;
   
    public $action;
    public $due_entry_obj;
    public $transaction_date;
    public $entry_month;
    public $description;
    
    // constructor with $db as database connection
    public function __construct($db){
        $this->conn = $db;
    }
	
// read Classes
function read(){
 
    // select all query
    $query = "SELECT I.*, S.sch_name FROM " . $this->table_ref . " AS I
        LEFT JOIN " . $this->table_school . " AS S
        ON I.school_id = S.id
        ";
 
    // prepare query statement
    $stmt = $this->conn->prepare($query);

    // execute query
    $stmt->execute();
 
    return $stmt;
}

// create product
function createVoucherRef(){

    // query to insert record
    $query = "INSERT INTO
                " . $this->table_ref . "
            SET
                school_id = :school_id,
                entry_month = :entry_month,
                description = :description,
                tr_date = :tr_date,
                session_year_id = :session_year_id";

    // prepare query
    $stmt = $this->conn->prepare($query);

    // sanitize
    $this->school_id = $this->school_id;
    $this->description = $this->description;
    $this->entry_month = $this->entry_month;
    $this->tr_date = $this->transaction_date;
    $this->session_year_id = $this->session_year_id;

    // bind values
    $stmt->bindParam(":school_id", $this->school_id);
    $stmt->bindParam(":entry_month", $this->entry_month);
    $stmt->bindParam(":description", $this->description);
    $stmt->bindParam(":tr_date", $this->tr_date);
    $stmt->bindParam(":session_year_id", $this->session_year_id);

    // echo"<pre>";print_r($stmt);echo"</pre>";die();
    // execute query
    if($stmt->execute()){
        $this->last_detail_id = $this->conn->lastInsertId();
        return true;
    }
    return false;
     
}

// create EntryBook records.
function createDueVoucherEntry(){
 
    $due_obj = $this->due_entry_obj;
    $entry_obj = Array();

    foreach($due_obj as $d_obj) { 
		  
        $this->createVoucherRef();
        
		if(!empty($this->last_detail_id)){

            if(is_array($d_obj->debit_item)){
                    // if Array
            } else {
                // if Object
                // echo"<pre>";print_r($d_obj->debit_item);echo"</pre>"; die();
                $s_info = Array();

                $s_info['vchr_ref_id'] = $this->last_detail_id;
                $s_info['ledger_id'] = $d_obj->debit_item->ledger_id;
                $s_info['ledger_type'] = "S";
                $s_info['group_code'] = $d_obj->debit_item->group_code;
                $s_info['ledger_folio'] = $d_obj->debit_item->ledger_id."_S_".$this->school_id;
                $s_info['tr_amount'] = $d_obj->debit_item->debit_amo; 
                $s_info['tr_type'] = "DR"; 

                $entry_obj[] = $s_info;
            }
            // echo"<pre>";print_r($entry_obj);echo"</pre>"; die();
            
            if(is_array($d_obj->credit_item)){
                // if Array
                foreach($d_obj->credit_item as $c_obj) { 
                    $s_info = Array();
                    
                    $s_info['vchr_ref_id'] = $this->last_detail_id;
                    $s_info['ledger_id'] = $c_obj->ledger_id;
                    $s_info['ledger_type'] = "O";
                    $s_info['group_code'] = $c_obj->group_code;
                    $s_info['ledger_folio'] = $c_obj->ledger_id."_O_".$this->school_id;
                    $s_info['tr_amount'] = $c_obj->credit_amo; 
                    $s_info['tr_type'] = "CR"; 

                    $entry_obj[] = $s_info;
                }

            } else {
                // if Object
            }
        }
    }

    // echo"<pre>";print_r(json_encode($entry_obj));echo"</pre>"; die();
    
	$query = "INSERT INTO 
		" . $this->table_vchr_entry . " 
            (school_id, vchr_ref_id, ledger_id, ledger_type, ledger_folio, tr_amount, tr_type, session_year_id) VALUES "; //Prequery
			
	$qPart = array_fill(0, count($entry_obj), "(?, ?, ?, ?, ?, ?, ?, ?)");
	$query .=  implode(",",$qPart);
	/*$query .= "ON DUPLICATE KEY UPDATE
				sub_name = VALUES(sub_name),
				sub_lavel = VALUES(sub_lavel)";*/
	
	$stmt = $this->conn->prepare($query);

	$i = 1;
	foreach($entry_obj as $e_obj) { 
		  // bind the values one by one for fee category
		  
        $stmt -> bindParam($i++, $this->school_id);
        $stmt -> bindParam($i++, $e_obj['vchr_ref_id']);
        $stmt -> bindParam($i++, $e_obj['ledger_id']);
        $stmt -> bindParam($i++, $e_obj['ledger_type']);
        $stmt -> bindParam($i++, $e_obj['ledger_folio']);
        $stmt -> bindParam($i++, $e_obj['tr_amount']); 
        $stmt -> bindParam($i++, $e_obj['tr_type']); 
        $stmt -> bindParam($i++, $this->session_year_id);
    }

	if($stmt->execute()){
        // update ledger current balance
        $this->updateLedgerWithBalance($entry_obj);
		return true;
	} else {
        return false;
    }
 
}
// update Ledger's With current balance in one query
function updateLedgerWithBalance($entry_obj){
	// $this->ledger_details;
    // SELECT * FROM `acc_voucher_entry` WHERE ledger_id IN ( 1,2,3,4,5 ) ORDER BY id DESC LIMIT 1
    // echo"<pre>";print_r(json_encode($entry_obj));echo"</pre>"; die();
    $whereIn4_L = Array();
    // get all unique ledger_folio ids from $entry_obj
    foreach($entry_obj as $obj) { 
        if(!in_array($obj['ledger_folio'], $whereIn4_L)){
            array_push($whereIn4_L, $obj['ledger_folio']);
        }
    }

    // echo"<pre>";print_r($whereIn4_L);echo"</pre>";// die();
    // echo"<pre>";print_r($whereIn4_G);echo"</pre>"; //die();
    // echo"<pre>";print_r($whereIn4_R);echo"</pre>"; die();

    // get all last entries of every ledger which is effected in this voucher entry 
    // from acc_ledger_entry table using $whereIn4_L

    $res_obj = $this->readCurrentLedgers($whereIn4_L);

    $ledger_obj = Array();
    $lgr_f_ids = Array();
    // $ledger_obj = $res_obj;
    // $lgr_f_ids = $lgr_f_ids;
     
    foreach($entry_obj as $e_obj) { 
        // bind the values one by one for fee category
        $lgr_obj = Array();
        // echo"<pre>";print_r($e_obj);echo"</pre>"; die();
        $lgr_obj['school_id'] = $this->school_id;
        $lgr_obj['vchr_ref_id'] = $e_obj['vchr_ref_id'];
        $lgr_obj['ledger_id'] = $e_obj['ledger_id'];
        $lgr_obj['ledger_type'] = $e_obj['ledger_type'];
        $lgr_obj['ledger_folio'] = $e_obj['ledger_folio'];
        $lgr_obj['group_code'] = $e_obj['group_code'];
        $crnt_folio = "'".$e_obj['ledger_folio']."'";

        if(!in_array($crnt_folio, $lgr_f_ids)){
            array_push($lgr_f_ids, $crnt_folio);
            
            $lgr_obj['op_balance'] = 0;
            $lgr_obj['op_type'] = "CR";
            $lgr_obj['tr_amount'] = $e_obj['tr_amount'];
            $lgr_obj['tr_type'] = $e_obj['tr_type'];
            $lgr_obj['cl_balance'] = $e_obj['tr_amount'];
            $lgr_obj['cl_type'] = $e_obj['tr_type'];
            $lgr_obj['session_year_id'] = $this->session_year_id;
            $ledger_obj[] = $lgr_obj;

            // echo"<pre>";print_r(in_array($crnt_folio, $lgr_f_ids));echo"</pre>"; die();
        } else {
            // echo"<pre>";print_r($ledger_obj);echo"</pre>";die();
            // filter and get last entries of ledger  
            
            // exist     crnt
            // cr = 200, dr = 500
            // calculate closing balance start this is increse of 
            // last entry
            $existing_obj = $this->getFilteredLedgerArray($crnt_folio, $ledger_obj);
            $clng_bal = 0;
            $clng_typ = $existing_obj['cl_type'];

            if($e_obj['tr_type'] === $existing_obj['op_type']){
                $clng_bal = $existing_obj['cl_balance'] + $e_obj['tr_amount'];
            } else {
                $chck_bal = $existing_obj['cl_balance'] - $e_obj['tr_amount'];
                if($chck_bal < 0){
                    $clng_typ = $e_obj['tr_type'];
                } 
                $clng_bal = abs($chck_bal);
            } 
            // calculate closing balance end

            $lgr_obj['op_balance'] = $existing_obj['cl_balance']; 
            $lgr_obj['op_type'] = $existing_obj['cl_type']; 
            $lgr_obj['tr_amount'] = $e_obj['tr_amount'];
            $lgr_obj['tr_type'] = $e_obj['tr_type'];
            $lgr_obj['cl_balance'] = $clng_bal;
            $lgr_obj['cl_type'] = $clng_typ;

            $lgr_obj['session_year_id'] = $this->session_year_id;
            $ledger_obj[] = $lgr_obj;
            
            // echo"<pre>";print_r($lgr_obj);echo"</pre>";die();
        }
    }
     
    
    // echo"<pre>";print_r(json_encode($ledger_obj));echo"</pre>"; die();
    
    // `school_id`, `vchr_ref_id`, `ledger_id`, `ledger_type`, `ledger_folio`, `op_balance`, `op_type`, `tr_amount`, `tr_type`, `cl_balance`, `cl_type`, `session_year_id`, `server_date_time`
    
    $query = "INSERT INTO 
        " . $this->table_ldgr_entry . " 
            (school_id, vchr_ref_id, ledger_id, ledger_type, ledger_folio, group_code,
                op_balance, op_type, tr_amount, tr_type, cl_balance, cl_type,
                session_year_id) VALUES "; //Prequery
            
    $qPart = array_fill(0, count($ledger_obj), "(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
    $query .=  implode(",",$qPart);
    /*$query .= "ON DUPLICATE KEY UPDATE
                sub_name = VALUES(sub_name),
                sub_lavel = VALUES(sub_lavel)";*/

    $stmt = $this->conn->prepare($query);

    $i = 1;
    foreach($ledger_obj as $e_obj) { 
        // bind the values one by one for fee category
        
        $stmt -> bindParam($i++, $this->school_id);
        $stmt -> bindParam($i++, $e_obj['vchr_ref_id']);
        $stmt -> bindParam($i++, $e_obj['ledger_id']);
        $stmt -> bindParam($i++, $e_obj['ledger_type']);
        $stmt -> bindParam($i++, $e_obj['ledger_folio']);
        $stmt -> bindParam($i++, $e_obj['group_code']);
        $stmt -> bindParam($i++, $e_obj['op_balance']); 
        $stmt -> bindParam($i++, $e_obj['op_type']); 
        $stmt -> bindParam($i++, $e_obj['tr_amount']); 
        $stmt -> bindParam($i++, $e_obj['tr_type']); 
        $stmt -> bindParam($i++, $e_obj['cl_balance']); 
        $stmt -> bindParam($i++, $e_obj['cl_type']); 
        $stmt -> bindParam($i++, $this->session_year_id);
    }
    if($stmt->execute()){
        // echo"<pre>";print_r($stmt);echo"</pre>"; die();
        // update ledger current balance
        $this->updateGroupWithBalance($ledger_obj);
        return true;
    } else {
        return false;
    }
    // Update Group Current Balance 

}


function getFilteredLedgerArray($crnt_folio, $ledger_obj) {
    $filtredArray = [];
    foreach($ledger_obj as $key => $value) {
        if($crnt_folio == "'".$value['ledger_folio']."'" ){
            $filtredArray = $value;
        } else {
            continue;
        }
    }
    return $filtredArray;
}

// update Group's current balance in one query
function updateGroupWithBalance($ledger_obj){
    
    $whereIn4_G = Array();
    $whereIn4_R = Array();
    foreach($ledger_obj as $obj) { 
        if(!in_array($obj['group_code'], $whereIn4_G)){
            array_push($whereIn4_G, $obj['group_code']);
        }
        if(!in_array($obj['vchr_ref_id'], $whereIn4_R)){
            array_push($whereIn4_R, $obj['vchr_ref_id']);
        }
    }
    // echo"<pre>";print_r($whereIn4_G);echo"</pre>"; // die();
    // echo"<pre>";print_r($whereIn4_L);echo"</pre>"; // die();
    // echo"<pre>";print_r($whereIn4_R);echo"</pre>"; die();

    function getLastTransValuesofGroup($code, $ref, $data){
        $amo = 0;
        foreach($data as $w_obj) {     
            if($code === $w_obj['group_code'] && $ref === $w_obj['vchr_ref_id'] ){
                $amo += $w_obj['tr_amount'];
            }
        };
        return $amo;
    }  
       
    // echo"<pre>";print_r($whereIn4_G);echo"</pre>"; die();
    $res_group_obj =  $this->readCurrentGroup($whereIn4_G);
    // echo"<pre>";print_r($res_group_obj);echo"</pre>"; die();
    $group_obj = Array();
    $group_codes = Array();

    foreach($whereIn4_R as $rId) { 
        foreach($whereIn4_G as $gId) { 
            $_index = 0;
            $sngl_g_obj = Array();
            
            foreach($ledger_obj as $g_obj) { 
                $crnt_group = $g_obj['group_code'];
                if($gId === $g_obj['group_code'] && $_index === 0){

                    // echo"<pre>";print_r($g_obj);echo"</pre>"; die();
                
                    $_tr_amo = getLastTransValuesofGroup($gId, $rId, $ledger_obj);
                    $sngl_g_obj['op_balance'] = 0;
                    $sngl_g_obj['op_type'] = $g_obj['op_type'];
                    $sngl_g_obj['tr_amount'] = $_tr_amo;
                    $sngl_g_obj['tr_type'] = $g_obj['tr_type'];
                    $sngl_g_obj['cl_balance'] = $_tr_amo;
                    $sngl_g_obj['cl_type'] = $g_obj['tr_type'];
                    $sngl_g_obj['group_code'] = $g_obj['group_code'];
                    $sngl_g_obj['school_id'] = $g_obj['school_id'];
                    $sngl_g_obj['session_year_id'] = $g_obj['session_year_id'];
                    $sngl_g_obj['vchr_ref_id'] = $g_obj['vchr_ref_id'];
                    $sngl_g_obj['group_folio'] = $g_obj['group_code'] ."_".$g_obj['school_id'];
                    $_index++;

                    // echo"<pre>";print_r("group_obj " . json_encode($sngl_g_obj));echo"</pre>"; die();
                }
                // if(!in_array($crnt_group, $group_codes)){
                // } else {
                // }
            };
            array_push($group_obj, $sngl_g_obj);
        }
    }
   
   //echo"<pre>";print_r(json_encode($group_obj));echo"</pre>"; die();
   
   // `school_id`, `vchr_ref_id`, `group_id`, `group_folio`, `group_code`
   // `op_balance`, `op_type`, `tr_amount`, `tr_type`, `cl_balance`, `cl_type`, 
   // `session_year_id`, `server_date_time`, 
   
   $query = "INSERT INTO 
       " . $this->table_grp_entry . " 
           (school_id, vchr_ref_id, group_folio, group_code,
               op_balance, op_type, tr_amount, tr_type, cl_balance, cl_type,
               session_year_id) VALUES "; //Prequery
           
   $qPart = array_fill(0, count($group_obj), "(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
   $query .=  implode(",",$qPart);
   /*$query .= "ON DUPLICATE KEY UPDATE
               sub_name = VALUES(sub_name),
               sub_lavel = VALUES(sub_lavel)";*/

   $stmt = $this->conn->prepare($query);

   $i = 1;
   foreach($group_obj as $gp_obj) { 
    // bind the values one by one for fee category
    // echo"<pre>";print_r($gp_obj);echo"</pre>"; die();

       $stmt -> bindParam($i++, $this->school_id);
       $stmt -> bindParam($i++, $gp_obj['vchr_ref_id']);
       $stmt -> bindParam($i++, $gp_obj['group_folio']);
       $stmt -> bindParam($i++, $gp_obj['group_code']); //
       $stmt -> bindParam($i++, $gp_obj['op_balance']); 
       $stmt -> bindParam($i++, $gp_obj['op_type']); 
       $stmt -> bindParam($i++, $gp_obj['tr_amount']); 
       $stmt -> bindParam($i++, $gp_obj['tr_type']); 
       $stmt -> bindParam($i++, $gp_obj['cl_balance']); 
       $stmt -> bindParam($i++, $gp_obj['cl_type']); 
       $stmt -> bindParam($i++, $this->session_year_id);
   }

   // echo"<pre>";print_r($stmt);echo"</pre>"; die();
   if($stmt->execute()){
       return true;
   } else {
       return false;
   }
   // Update Group Current Balance 

}

function getFilteredGroupArray($grp_code, $group_obj) {
    $filtredArray = [];
    foreach($group_obj as $key => $value) {
        if($grp_code == strval($grp_code)){
            $filtredArray = $value;
        } else {
            continue;
        }
    }
    return $filtredArray;
}

// used when filling up the update product form
function readCurrentLedgers($where_in){
 
    // query to read single record
    $where_str = implode("', '",$where_in);
    
    $query = "SELECT * FROM " . $this->table_ldgr_entry . " WHERE id IN (SELECT MAX(id) 
                FROM " . $this->table_ldgr_entry . " WHERE ledger_folio IN ( '$where_str' ) 
                GROUP BY ledger_folio);";

    // prepare query statement
    $stmt = $this->conn->prepare( $query );
    
    // execute query
    $stmt->execute();
    $num = $stmt->rowCount();
    if ($num > 0)
    {
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC))
        {
            extract($row);
            // echo"<pre>";print_r($row);echo"</pre>"; die();
            $entry_item = array();
    
            $entry_item['id'] = $Item->id;
            $entry_item['school_id'] = $row['school_id'];
            $entry_item['vchr_ref_id'] = $row['vchr_ref_id'];
            $entry_item['ledger_id'] = $row['ledger_id'];
            $entry_item['ledger_type'] = $row['ledger_type'];
            $entry_item['ledger_folio'] = $row['ledger_folio'];
            $entry_item['op_balance'] = $row['op_balance'];
            $entry_item['op_type'] = $row['op_type'];
            $entry_item['tr_amount'] = $row['tr_amount'];
            $entry_item['tr_type'] = $row['tr_type'];
            $entry_item['cl_balance'] = $row['cl_balance'];
            $entry_item['cl_type'] = $row['cl_type'];
            $entry_item['school_name'] = $row['sch_name'];
            $entry_item['tr_date'] = $row['tr_date'];
            $entry_item['session_year_id'] = $row['session_year_id'];
            $entry_item['server_date_time'] = $row['server_date_time'];
            $entry_item['group_code'] = $row['group_code'];
            
        }
        return true;
    } else {
        return false;
    }
 
}

// used when filling up the update product form
function readCurrentGroup($where_in){
 
    // query to read single record
    $where_str = implode(", ",$where_in);
    
    $query = "SELECT * FROM " . $this->table_grp_entry . " 
            WHERE group_folio IN ( :where_str )
            GROUP BY group_folio";

    // prepare query statement
    $stmt = $this->conn->prepare( $query );
    
    // bind id of product to be updated
    $stmt->bindParam(":where_str", $where_str);

    // execute query
    // echo"<pre>";print_r($stmt);echo"</pre>"; die();
    $stmt->execute();
    $num = $stmt->rowCount();
    echo"<pre>";print_r($num);echo"</pre>"; die();

    if ($num > 0)
    {
        $entry_item = array();
        while ($row = $stmt->fetch(PDO::FETCH_ASSOC))
        {
            extract($row);
            echo"<pre>";print_r($row);echo"</pre>"; die();
            $entry_item['id'] = $Item->id;
            $entry_item['school_id'] = $row['school_id'];
            $entry_item['school_name'] = $row['sch_name'];
            $entry_item['tr_date'] = $row['tr_date'];
            $entry_item['description'] = $row['description'];
            $entry_item['session_year_id'] = $row['session_year_id'];
            $entry_item['server_date_time'] = $row['server_date_time'];

        }
        return true;
    } else {
        return false;
    }

 
}
 
// used when filling up the update product form
function readOne(){
 
    // query to read single record
     
    $query = "SELECT I.*, S.sch_name FROM " . $this->table_ref . " AS I
        LEFT JOIN " . $this->table_school . " AS S
        ON I.school_id = S.id
        WHERE
                I.id = ?
            LIMIT
                0,1";

	// prepare query statement
    $stmt = $this->conn->prepare( $query );
	
    // bind id of product to be updated
    $stmt->bindParam(1, $this->id);
    // execute query
    $stmt->execute();
 
    return $stmt;
 
}

  
// update the product
function update(){
	
    // update query
    $query = "UPDATE
                " . $this->table_ref . "
            SET
				school_id = :school_id,
                amount = :amount,
                description = :description,
                transaction_date = :transaction_date,
                session_year_id = :session_year_id
				
            WHERE
                id = :id";
	
    // prepare query statement
    $stmt = $this->conn->prepare($query);
	
    // sanitize
    $this->id 				= $this->id;
	$this->school_id = $this->school_id;
    $this->amount = $this->amount;
    $this->description = $this->description;
    $this->transaction_date = $this->transaction_date;
    $this->session_year_id = $this->session_year_id;
    
    // bind values
	$stmt->bindParam(":id", $this->id);
	$stmt->bindParam(":school_id", $this->school_id);
    $stmt->bindParam(":amount", $this->amount);
    $stmt->bindParam(":description", $this->description);
    $stmt->bindParam(":transaction_date", $this->transaction_date);
    $stmt->bindParam(":session_year_id", $this->session_year_id);
    
    // echo"<pre>";print_r($stmt);echo"</pre>";die();
    // execute the query
    if($stmt->execute()){
        return true;  
    }
 
    return false;
}

// delete the product
function delete(){
 
    // delete query
    $query = "DELETE FROM " . $this->table_ref . " WHERE id = :id";
 
    // prepare query
    $stmt = $this->conn->prepare($query);
 
    // sanitize
    $this->id=htmlspecialchars(strip_tags($this->id));
 
    // bind id of record to delete
    $stmt->bindParam(':id', $this->id);
 
    // echo"<pre>";print_r($stmt);echo"</pre>";die();
    // execute query
    if($stmt->execute()){
        return true;
    }
    return false;
}

function getMonthFromDate($tr_date){
    
    $timestamp = strtotime($tr_date);
    $month = date("m", $timestamp);

    return $month;
}

}



 
