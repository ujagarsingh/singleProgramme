
SELECT * FROM acc_ledger_entry WHERE id IN (SELECT MAX(id) 
FROM acc_ledger_entry WHERE ledger_folio IN ('106_S_4', '20_O_4') 
GROUP BY ledger_folio);
<!DOCTYPE HTML>
<html lang="en-US"><head>
    
</head>

<body>
<script>
let _data = [{"school_id":"4","vchr_ref_id":"758","ledger_id":"106","ledger_type":"S","group_code":"1003","effected_ledger":"106-S-4","op_balance":0,"op_type":"CR","tr_amount":612,"tr_type":"DR","cl_balance":612,"cl_type":"DR","session_year_id":"1"},{"school_id":"4","vchr_ref_id":"758","ledger_id":"20","ledger_type":"O","group_code":"1002","effected_ledger":"20-O-4","op_balance":612,"op_type":"DR","tr_amount":"5","tr_type":"CR","cl_balance":617,"cl_type":"DR","session_year_id":"1"},{"school_id":"4","vchr_ref_id":"758","ledger_id":"17","ledger_type":"O","group_code":"1002","effected_ledger":"17-O-4","op_balance":617,"op_type":"DR","tr_amount":"45","tr_type":"CR","cl_balance":572,"cl_type":"DR","session_year_id":"1"},{"school_id":"4","vchr_ref_id":"758","ledger_id":"16","ledger_type":"O","group_code":"1002","effected_ledger":"16-O-4","op_balance":572,"op_type":"DR","tr_amount":"454","tr_type":"CR","cl_balance":118,"cl_type":"DR","session_year_id":"1"},{"school_id":"4","vchr_ref_id":"758","ledger_id":"19","ledger_type":"O","group_code":"1002","effected_ledger":"19-O-4","op_balance":118,"op_type":"DR","tr_amount":"54","tr_type":"CR","cl_balance":64,"cl_type":"DR","session_year_id":"1"},{"school_id":"4","vchr_ref_id":"758","ledger_id":"15","ledger_type":"O","group_code":"1002","effected_ledger":"15-O-4","op_balance":64,"op_type":"DR","tr_amount":"54","tr_type":"CR","cl_balance":10,"cl_type":"DR","session_year_id":"1"},{"school_id":"4","vchr_ref_id":"759","ledger_id":"81","ledger_type":"S","group_code":"1003","effected_ledger":"81-S-4","op_balance":10,"op_type":"DR","tr_amount":612,"tr_type":"DR","cl_balance":622,"cl_type":"DR","session_year_id":"1"},{"school_id":"4","vchr_ref_id":"759","ledger_id":"20","ledger_type":"O","group_code":"1002","effected_ledger":"20-O-4","op_balance":622,"op_type":"DR","tr_amount":"5","tr_type":"CR","cl_balance":617,"cl_type":"DR","session_year_id":"1"},{"school_id":"4","vchr_ref_id":"759","ledger_id":"17","ledger_type":"O","group_code":"1002","effected_ledger":"17-O-4","op_balance":617,"op_type":"DR","tr_amount":"45","tr_type":"CR","cl_balance":572,"cl_type":"DR","session_year_id":"1"},{"school_id":"4","vchr_ref_id":"759","ledger_id":"16","ledger_type":"O","group_code":"1002","effected_ledger":"16-O-4","op_balance":572,"op_type":"DR","tr_amount":"454","tr_type":"CR","cl_balance":118,"cl_type":"DR","session_year_id":"1"},{"school_id":"4","vchr_ref_id":"759","ledger_id":"19","ledger_type":"O","group_code":"1002","effected_ledger":"19-O-4","op_balance":118,"op_type":"DR","tr_amount":"54","tr_type":"CR","cl_balance":64,"cl_type":"DR","session_year_id":"1"},{"school_id":"4","vchr_ref_id":"759","ledger_id":"15","ledger_type":"O","group_code":"1002","effected_ledger":"15-O-4","op_balance":64,"op_type":"DR","tr_amount":"54","tr_type":"CR","cl_balance":10,"cl_type":"DR","session_year_id":"1"},{"school_id":"4","vchr_ref_id":"760","ledger_id":"71","ledger_type":"S","group_code":"1003","effected_ledger":"71-S-4","op_balance":10,"op_type":"DR","tr_amount":612,"tr_type":"DR","cl_balance":622,"cl_type":"DR","session_year_id":"1"},{"school_id":"4","vchr_ref_id":"760","ledger_id":"20","ledger_type":"O","group_code":"1002","effected_ledger":"20-O-4","op_balance":622,"op_type":"DR","tr_amount":"5","tr_type":"CR","cl_balance":617,"cl_type":"DR","session_year_id":"1"},{"school_id":"4","vchr_ref_id":"760","ledger_id":"17","ledger_type":"O","group_code":"1002","effected_ledger":"17-O-4","op_balance":617,"op_type":"DR","tr_amount":"45","tr_type":"CR","cl_balance":572,"cl_type":"DR","session_year_id":"1"},{"school_id":"4","vchr_ref_id":"760","ledger_id":"16","ledger_type":"O","group_code":"1002","effected_ledger":"16-O-4","op_balance":572,"op_type":"DR","tr_amount":"454","tr_type":"CR","cl_balance":118,"cl_type":"DR","session_year_id":"1"},{"school_id":"4","vchr_ref_id":"760","ledger_id":"19","ledger_type":"O","group_code":"1002","effected_ledger":"19-O-4","op_balance":118,"op_type":"DR","tr_amount":"54","tr_type":"CR","cl_balance":64,"cl_type":"DR","session_year_id":"1"},{"school_id":"4","vchr_ref_id":"760","ledger_id":"15","ledger_type":"O","group_code":"1002","effected_ledger":"15-O-4","op_balance":64,"op_type":"DR","tr_amount":"54","tr_type":"CR","cl_balance":10,"cl_type":"DR","session_year_id":"1"},{"school_id":"4","vchr_ref_id":"761","ledger_id":"88","ledger_type":"S","group_code":"1003","effected_ledger":"88-S-4","op_balance":10,"op_type":"DR","tr_amount":612,"tr_type":"DR","cl_balance":622,"cl_type":"DR","session_year_id":"1"},{"school_id":"4","vchr_ref_id":"761","ledger_id":"20","ledger_type":"O","group_code":"1002","effected_ledger":"20-O-4","op_balance":622,"op_type":"DR","tr_amount":"5","tr_type":"CR","cl_balance":617,"cl_type":"DR","session_year_id":"1"},{"school_id":"4","vchr_ref_id":"761","ledger_id":"17","ledger_type":"O","group_code":"1002","effected_ledger":"17-O-4","op_balance":617,"op_type":"DR","tr_amount":"45","tr_type":"CR","cl_balance":572,"cl_type":"DR","session_year_id":"1"},{"school_id":"4","vchr_ref_id":"761","ledger_id":"16","ledger_type":"O","group_code":"1002","effected_ledger":"16-O-4","op_balance":572,"op_type":"DR","tr_amount":"454","tr_type":"CR","cl_balance":118,"cl_type":"DR","session_year_id":"1"},{"school_id":"4","vchr_ref_id":"761","ledger_id":"19","ledger_type":"O","group_code":"1002","effected_ledger":"19-O-4","op_balance":118,"op_type":"DR","tr_amount":"54","tr_type":"CR","cl_balance":64,"cl_type":"DR","session_year_id":"1"},{"school_id":"4","vchr_ref_id":"761","ledger_id":"15","ledger_type":"O","group_code":"1002","effected_ledger":"15-O-4","op_balance":64,"op_type":"DR","tr_amount":"54","tr_type":"CR","cl_balance":10,"cl_type":"DR","session_year_id":"1"}];

// console.log(_data);

let group_obj = [];
let ledger_obj = [];
let _group_ids = [];
let _ledger_ids = [];

_data.map((item)=>{
    if(!_ledger_ids.includes(item.effected_ledger)){
        _ledger_ids.push(item.effected_ledger);
    }
    if(!_group_ids.includes(item.group_code)){
        _group_ids.push(item.group_code);
    }
})
console.log(_group_ids);
console.log(_ledger_ids);

function getLastTransValuesofGroup(code, data){
    console.log(code);
    console.log(data);

}

function groupWise(data){
    _group_ids.map((item)=>{
        let _g_obj = {};
        data.map((g_item)=>{
            let _index = 0;
            if(item === g_item.group_code && _index === 0){
                _g_obj = g_item;
                const _f_obj = getLastTransValuesofGroup(item, data)
                _index++;
            }
        })
        group_obj.push(_g_obj);
    })
    console.log(group_obj);
}

function ledgerWise(){}
function entryWise(data){}

groupWise(_data);

</script>    

</body>

</html>
