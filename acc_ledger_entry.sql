
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>GrapesJS Demo - Free Open Source Website Page Builder</title>
<style>
table, td {
  border: 1px solid black;
  height: 30px;
}
</style>
  </head>
  <body>
     <div id="abc"></div>
    <table >
    <thead>
        <tr class="ui-widget-header ">
            <th>Name/Nr.</th>
            <th>Street</th>
            <th>Town</th>
            <th>Postcode</th>
            <th>Country</th>
            <th>Options</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td class="nr"><span>50</span>
            </td>
            <td>Some Street 1</td>
            <td>Glasgow</td>
            <td>G0 0XX</td>
            <td>United Kingdom</td>
            <td>
                <button type="button" class="use-address" />
            </td>
        </tr>
        <tr>
            <td class="nr">49</td>
            <td>Some Street 2</td>
            <td>Glasgow</td>
            <td>G0 0XX</td>
            <td>United Kingdom</td>
            <td>
                <button type="button" class="use-address" />
            </td>
        </tr>
    </tbody>
</table>
  </body>

  <script
  src="https://code.jquery.com/jquery-3.5.1.js"
  integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
  crossorigin="anonymous"></script>

<script>

    
var data =  {
            "id": "2474",
            "school_id": "4",
            "school_name": "Jyoti Public Senior Sec. School",
            "tr_date": "2020-10-15",
            "entry_month": "8",
            "description": "Due Fee Entry Details of Month August.",
            "session_year_id": "1",
            "vouchers": [
                {
                    "id": "8774",
                    "ledger_id": "106",
                    "ledger_type": "S",
                    "ledger_folio": "106_S_4",
                    "tr_amount": "558",
                    "tr_type": "DR"
                },
                {
                    "id": "8775",
                    "ledger_id": "15",
                    "ledger_type": "O",
                    "ledger_folio": "15_S_4",
                    "tr_amount": "54",
                    "tr_type": "CR"
                },
                {
                    "id": "8776",
                    "ledger_id": "20",
                    "ledger_type": "O",
                    "ledger_folio": "20_S_4",
                    "tr_amount": "5",
                    "tr_type": "CR"
                },
                {
                    "id": "8777",
                    "ledger_id": "17",
                    "ledger_type": "O",
                    "ledger_folio": "17_S_4",
                    "tr_amount": "45",
                    "tr_type": "CR"
                },
                {
                    "id": "8778",
                    "ledger_id": "16",
                    "ledger_type": "O",
                    "ledger_folio": "16_S_4",
                    "tr_amount": "454",
                    "tr_type": "CR"
                }
            ]
        } ;

 function showVoucherEntries(vchr_obj) {
   let _all_dr = [];
   let _all_cr = [];
   let _total_dr = 0;
   let _total_cr = 0;

   vchr_obj.vouchers.map((vItem) => {
      if (vItem.tr_type === 'DR') {
         _all_dr = [..._all_dr, vItem];
         _total_dr += Number(vItem.tr_amount);
      } else {
         _all_cr = [..._all_cr, vItem];
         _total_cr += Number(vItem.tr_amount);
      }
   });

   let vchr_table = `<table className="table table-sm table-light table-voucher m-0">
      <thead>
         <tr>
            <th></th>
            <th className="text-center">Debit</th>
            <th className="text-center">Credit</th>
         </tr>
      </thead>
      <tfoot className="bg-light">
         <tr>
            <th className="text-right">TOTAL</th>
            <th className="text-right">${_total_dr}/-</th>
            <th className="text-right">${_total_cr}/-</th>
         </tr>
      </tfoot>
      <tbody>`; 

   vchr_table +=  _all_dr.map((dr_item, dr_inx) => {
            return (
               `<tr>
                  <td>
                     <span className="ml-0"> ${dr_item.ledger_folio} <b>Ujagar Singh s/o Shri Birdi Chand Meena </b> [ Class : 10nth ] DR </span>
                  </td>
                  <td className="text-right">${dr_item.tr_amount}/-</td>
                  <td className="text-right"></td>
               </tr>`
            )
         }) ; 

   vchr_table += _all_cr.map((cr_item, cr_inx) => {
            return (
               `<tr>
                  <td>
                     <span className="ml-4"><i>To,</i> ${cr_item.ledger_folio}</span>
                  </td>
                  <td className="text-right"></td>
                  <td className="text-right">${cr_item.tr_amount}/-</td>
               </tr>`
            )
         });
         
   vchr_table += `<tr>
            <td>
               <div className="">
                  <p className="m-0"><b>Naretion : </b> <br /> this is the area of Naretion..</p>
               </div>
            </td>
            <td className="text-right"></td>
            <td className="text-right"></td>
         </tr>

      </tbody>
   </table>`;
   
   return vchr_table;
};

const _tbl = showVoucherEntries(data);
document.getElementById('abc').innerHTML = _tbl;

</script>


<script>
    let _current_clone = '';
    let _current_td = '';
    let _current_row = '';

    function createMenuBar(){
      const _td = $(this)[0];
      createToolBar(_td);
      getTableRow(_td);
    };


    function getTableRow(_td){
      const row = _td.closest("tr");
      
      const clone = row.cloneNode(true);

      _current_row = row;
      _current_clone = clone;

      const td_child = _current_clone.children;
      const td_arr = Array.prototype.slice.call(td_child);
      td_arr.map((item)=>{
        item.addEventListener("click", createMenuBar);
        item.innerHTML = null;
      })
    };
    function duplicateRow(caller){
      const row   = caller.parentNode.parentNode;  // Caller is always a button inside a cell inside a row
      const clone = row.cloneNode(true);

      row.parentNode.insertBefore(clone, row.nextElementSibling);
    }

    function removeToolbar(){
      const _btnbar = document.querySelector("#btn-aflatoon");
      _btnbar.remove();
    }
    
    function insertAfterFun(){
      // alert('after');
      removeToolbar();
      _current_row.parentNode.insertBefore(_current_clone, _current_row.nextElementSibling);
    };
    function insertBeforeFun(){
      // alert('before');
      removeToolbar();
      _current_row.parentNode.insertBefore(_current_clone, _current_row);
    };

    function createToolBar(_td){
      console.log(_td);
      const _style = `
          position : fixed;
          left : ${_td.offsetLeft}px;
          top : ${_td.offsetTop}px;
          padding:5px;
          width:180px;
          margin-top:15px;
          margin-left:-50px;
          background:#ccc;
          z-index : 10;
          text-align: center
        `;

      const _html = `<div id="btn-aflatoon" style="${_style}">
            <button type="button" onclick="insertAfterFun()">Insert After</button> 
            <button type="button" onclick="insertBeforeFun()">Insert Before</button> 
          </div>`;
      $(_html).appendTo( "body" );
      

    }

   
    

    const _td =  document.querySelectorAll('td');
    const td_arr = Array.prototype.slice.call(_td);
    td_arr.map((item)=>{
      item.addEventListener("click", createMenuBar);
    })
  

  </script>
</html>
