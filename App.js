function dataObj(){
    var filterData = ['First Test', 'Second Test'];
    var _update_class = {};
    let _new_student_data =  _data.student.map((item_s, inx) => {
      
            const student_record = {};
            let _new_subjectData = item_s.subject.map((item_sub, iex) => {
                
                    const sub_record = {};
                    let _new_exams = item_sub.exams.filter((item_e, idx) => {
                        var _abc = null;
                        const _filterData = filterData.filter((element)=>{
                            if(item_e.exam_name == element){
                                _abc = item_e;
                            }
                        })
                        return _abc;
                    });

                sub_record['id'] = item_sub.id;
                sub_record['sub_lavel'] = item_sub.sub_lavel;
                sub_record['sub_name'] = item_sub.sub_name;
                sub_record['t_mm'] = item_sub.t_mm;
                sub_record['t_mo'] = item_sub.t_mo;
                sub_record['exams'] = _new_exams;

                return sub_record;
                });

            student_record['admission_number'] = item_s.admission_number;
            student_record['student_name'] = item_s.student_name;
            student_record['father_name'] = item_s.father_name;
            student_record['subject'] = _new_subjectData;

            console.log(student_record);
        return student_record;
		});
        
        _update_class['id'] = _data.id;
        _update_class['class_name'] = _data.class_name;
        _update_class['class_name_portal'] = _data.class_name_portal;
        _update_class['checked'] = _data.checked;
        
        _update_class['student'] = _new_student_data;

    console.log(_update_class);
}
