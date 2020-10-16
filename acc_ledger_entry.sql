

 function showVoucherEntries(vchr_obj) {
   let _all_dr = [];
   let _all_cr = [];
   let _total_dr = 0;
   let _total_cr = 0;

   vchr_obj.map((vItem) => {
      if (vItem.tr_type === 'DR') {
         _all_dr = [..._all_dr, vItem];
         _total_dr += Number(vItem.tr_amount);
      } else {
         _all_cr = [..._all_cr, vItem];
         _total_cr += Number(vItem.tr_amount);
      }
   });

   let vchr_table = <table className="table table-sm table-light table-voucher m-0">
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
            <th className="text-right">{_total_dr}/-</th>
            <th className="text-right">{_total_cr}/-</th>
         </tr>
      </tfoot>
      <tbody>
         {_all_dr.map((dr_item, dr_inx) => {
            return (
               <tr key={dr_inx}>
                  <td>
                     <span className="ml-0"> {dr_item.ledger_folio} <b>Ujagar Singh s/o Shri Birdi Chand Meena </b> [ Class : 10nth ] DR </span>
                  </td>
                  <td className="text-right">{dr_item.tr_amount}/-</td>
                  <td className="text-right"></td>
               </tr>
            )
         })}
         {_all_cr.map((cr_item, cr_inx) => {
            return (
               <tr key={cr_inx}>
                  <td>
                     <span className="ml-4"><i>To,</i> {cr_item.ledger_folio}</span>
                  </td>
                  <td className="text-right"></td>
                  <td className="text-right">{cr_item.tr_amount}/-</td>
               </tr>
            )
         })}
         <tr>
            <td>
               <div className="">
                  <p className="m-0"><b>Naretion : </b> <br /> this is the area of Naretion..</p>
               </div>
            </td>
            <td className="text-right"></td>
            <td className="text-right"></td>
         </tr>

      </tbody>
   </table>;

   return vchr_table;
}

{
    "message": "Access granted.",
    "entry_detail_arr": [
        {
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
        },
        {
            "id": "2475",
            "school_id": "4",
            "school_name": "Jyoti Public Senior Sec. School",
            "tr_date": "2020-10-15",
            "entry_month": "8",
            "description": "Due Fee Entry Details of Month August.",
            "session_year_id": "1",
            "vouchers": [
                {
                    "id": "8779",
                    "ledger_id": "81",
                    "ledger_type": "S",
                    "ledger_folio": "81_S_4",
                    "tr_amount": "558",
                    "tr_type": "DR"
                },
                {
                    "id": "8780",
                    "ledger_id": "15",
                    "ledger_type": "O",
                    "ledger_folio": "15_S_4",
                    "tr_amount": "54",
                    "tr_type": "CR"
                },
                {
                    "id": "8781",
                    "ledger_id": "20",
                    "ledger_type": "O",
                    "ledger_folio": "20_S_4",
                    "tr_amount": "5",
                    "tr_type": "CR"
                },
                {
                    "id": "8782",
                    "ledger_id": "17",
                    "ledger_type": "O",
                    "ledger_folio": "17_S_4",
                    "tr_amount": "45",
                    "tr_type": "CR"
                },
                {
                    "id": "8783",
                    "ledger_id": "16",
                    "ledger_type": "O",
                    "ledger_folio": "16_S_4",
                    "tr_amount": "454",
                    "tr_type": "CR"
                }
            ]
        },
        {
            "id": "2476",
            "school_id": "4",
            "school_name": "Jyoti Public Senior Sec. School",
            "tr_date": "2020-10-15",
            "entry_month": "8",
            "description": "Due Fee Entry Details of Month August.",
            "session_year_id": "1",
            "vouchers": [
                {
                    "id": "8784",
                    "ledger_id": "71",
                    "ledger_type": "S",
                    "ledger_folio": "71_S_4",
                    "tr_amount": "558",
                    "tr_type": "DR"
                },
                {
                    "id": "8785",
                    "ledger_id": "15",
                    "ledger_type": "O",
                    "ledger_folio": "15_S_4",
                    "tr_amount": "54",
                    "tr_type": "CR"
                },
                {
                    "id": "8786",
                    "ledger_id": "20",
                    "ledger_type": "O",
                    "ledger_folio": "20_S_4",
                    "tr_amount": "5",
                    "tr_type": "CR"
                },
                {
                    "id": "8787",
                    "ledger_id": "17",
                    "ledger_type": "O",
                    "ledger_folio": "17_S_4",
                    "tr_amount": "45",
                    "tr_type": "CR"
                },
                {
                    "id": "8788",
                    "ledger_id": "16",
                    "ledger_type": "O",
                    "ledger_folio": "16_S_4",
                    "tr_amount": "454",
                    "tr_type": "CR"
                }
            ]
        },
        {
            "id": "2477",
            "school_id": "4",
            "school_name": "Jyoti Public Senior Sec. School",
            "tr_date": "2020-10-15",
            "entry_month": "8",
            "description": "Due Fee Entry Details of Month August.",
            "session_year_id": "1",
            "vouchers": [
                {
                    "id": "8789",
                    "ledger_id": "88",
                    "ledger_type": "S",
                    "ledger_folio": "88_S_4",
                    "tr_amount": "558",
                    "tr_type": "DR"
                },
                {
                    "id": "8790",
                    "ledger_id": "15",
                    "ledger_type": "O",
                    "ledger_folio": "15_S_4",
                    "tr_amount": "54",
                    "tr_type": "CR"
                },
                {
                    "id": "8791",
                    "ledger_id": "20",
                    "ledger_type": "O",
                    "ledger_folio": "20_S_4",
                    "tr_amount": "5",
                    "tr_type": "CR"
                },
                {
                    "id": "8792",
                    "ledger_id": "17",
                    "ledger_type": "O",
                    "ledger_folio": "17_S_4",
                    "tr_amount": "45",
                    "tr_type": "CR"
                },
                {
                    "id": "8793",
                    "ledger_id": "16",
                    "ledger_type": "O",
                    "ledger_folio": "16_S_4",
                    "tr_amount": "454",
                    "tr_type": "CR"
                }
            ]
        }
    ]
}
