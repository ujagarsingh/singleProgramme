import React, { Component } from 'react';
import { Prompt, withRouter } from 'react-router';
import { NavLink } from 'react-router-dom';
import axios from 'axios';
//import Picky from 'react-picky';
//import DatePicker from 'react-date-picker';
import { loadProgressBar } from 'axios-progress-bar';
import Alert from 'react-s-alert';
//import { confirmAlert } from 'react-confirm-alert';
import { Helmet } from "react-helmet";
//import { HOST_URL } from '../includes/api-config';
import ExcelReader from '../utility/ExcelReader';
import { ExportCSV } from '../utility/Export_CSV/ExportCSV';
//import { isPending } from 'q';

const DIS_CONTINUE_SUDENTS = `http://localhost/schooloffice/api/portal_student/dis_continue_students.php`;
const CREATE_SUDENTS = `http://localhost/schooloffice/api/portal_student/create.php`;
const READ_CLASS_STUDENT = `http://localhost/schooloffice/api/students/read.php`;
const READ_SCHOOLS = `http://localhost/schooloffice/api/school/read.php`;

class UploadExcel extends Component {
  state = {
    schools_arr: [],
    students: [],
    filtered_students: [],
    dis_continue_students: [],
    new_students: [],
    old_student_Obj: [],
    student_Obj: [],
    medium_arr: [],
    medium: '',
    staff_Obj: [],
    errorMessages: '',
    successMessages: '',
    formIsHalfFilledOut: false,
    dummy_stu_data: [],
  }
  isEmpty(val) {
    return (val === undefined || val == null || val.length <= 0) ? true : false;
  }
  changeHandler = (event, fieldName, isCheckbox) => {
    if (fieldName === 'school') {
      const _inx = event.target.value;
      const _sch_id = (!this.isEmpty(_inx)) ? this.state.schools_arr[_inx].id : '';
      const _medium = (!this.isEmpty(_inx)) ? this.state.schools_arr[_inx].sch_medium : [];
      sessionStorage.setItem("school_id", _sch_id);
      this.setState({
        school_id: _sch_id,
        medium_arr: _medium,
        medium: (_medium.length === 1 ? _medium[0] : ''),
        selected_school_index: _inx,
      }, () => {
        this.filterStudentsOfSchool(_sch_id);
      })
    } else if (fieldName === 'medium') {
      const _medium = event.target.value;
      sessionStorage.setItem("medium", _medium);
      this.mediumHandler(_medium);
      this.setState({
        [fieldName]: isCheckbox ? event.target.checked : event.target.value,
      });
    } else {
      this.setState({
        [fieldName]: isCheckbox ? event.target.checked : event.target.value,
        formIsHalfFilledOut: true
      })
    }
  };
  createDummyStudentCsv() {
    let item = [{
      s_id: '',
      student_name: '',
      father_name: '',
      mother_name: '',
      studying_in_class: '',
      medium: '',
      admission_number: '',
      social_category: '',
      gender: '',
      dob: '',
      getting_free_education: ''
    }];

    this.setState({
      dummy_stu_data: item
    })
  }
  filterStudentsOfSchool(sch_id) {
    const _students = this.state.students;
    const _filtered_students = _students.filter((item) => {
      if (item.school_id === sch_id) {
        return item
      }
    })
    this.setState({
      filtered_students: _filtered_students
    })
  }
  matchStudent(data_1, data_2) {
    // getting data_1 to whitch is not meet in data_2;
    const _obj = data_1.filter((online_item) => {
      let flag = true;
      data_2.forEach((sofware_item) => {
        if (online_item.admission_number == sofware_item.admission_number) {
          flag = false
        }
      })
      if (flag) {
        return online_item
      }
    })
    return _obj
  }
  matchUpdatedStudent(data_1, data_2) {
    // getting data which is updated;
    const _obj = data_1.filter((online_item) => {
      let flag = true;
      data_2.forEach((sofware_item) => {
        if (online_item.admission_number == sofware_item.admission_number) {
          if (
            online_item.student_name !== sofware_item.student_name ||
            online_item.father_name !== sofware_item.father_name ||
            online_item.mother_name !== sofware_item.mother_name ||
            online_item.studying_in_class !== sofware_item.studying_in_class ||
            online_item.medium !== sofware_item.medium ||
            online_item.admission_number !== sofware_item.admission_number ||
            online_item.social_category !== sofware_item.social_category ||
            online_item.gender !== sofware_item.gender ||
            online_item.dob !== sofware_item.dob ||
            online_item.getting_free_education !== sofware_item.getting_free_education
          ) {
            flag = false
          }
          //flag = false
        }
      })
      if (flag) {
        return online_item
      }
    })
    console.log(_obj);
    debugger
    return _obj
  }
  convertDateForDatabaseType(stu_dob) {
    let new_dob = '';
    if (stu_dob.includes('/')) {
      new_dob = stu_dob.split('/');
    } else if (stu_dob.includes('-')) {
      new_dob = stu_dob.split('-');
    } else if (stu_dob.includes('.')) {
      new_dob = stu_dob.split('.');
    }

    const new_date = new_dob[2] + '-' + new_dob[1] + '-' + new_dob[0];
    return new_date;
  }

  studentObjHandler = (new_obj) => {
    const filtered = this.state.filtered_students;
    const dis_continue_students = this.matchStudent(filtered, new_obj);
    const new_students = this.matchStudent(new_obj, filtered);
    const updated_students = this.matchUpdatedStudent(filtered, new_obj);

    const stu_chng_date_type = new_students.map((new_item) => {
      let stu_dob = this.convertDateForDatabaseType(new_item['dob']);
      new_item = { ...new_item, dob: stu_dob }
      return new_item
    })

    this.setState({
      dis_continue_students: dis_continue_students,
      new_students: stu_chng_date_type
    })
  }

  staffObjHandler = (obj) => {
    loadProgressBar();
    const _obj = obj.map((item) => {
      const _dob = item.dob;
      const _newdob = _dob.replace(/(..).(..).(....)/, "$3-$1-$2")
      const _item = { ...item };
      _item.dob = _newdob;
      _item.u_dise_code = ''; _item.psp_code = ''; _item.aadhar_number = ''; _item.religion = '';
      _item.mother_tongue = ''; _item.rural_urban = ''; _item.habitation_or_locality = '';
      _item.date_of_admission = ''; _item.admission_number = ''; _item.belong_to_bpl = '';
      _item.belong_to_disadvantaged_group = ''; _item.getting_free_education = '';
      _item.studying_in_class = ''; _item.class_studied_in_prev_year = ''; _item.status_of_previous_year = '';
      _item.days_child_attended_school = ''; _item.medium_of_instruction = ''; _item.type_of_disablity = '';
      _item.facilities_received_by_cwsn = ''; _item.no_of_uniform_sets = ''; _item.free_text_books = '';
      _item.free_transport = ''; _item.free_escort = ''; _item.mdm_beneficiary = ''; _item.free_hostel_facility = '';
      _item.child_attended_special_training = ''; _item.child_is_homeless = ''; _item.appeard = ''; _item.passed = '';
      _item.percentage_marks = ''; _item.stream_grades_11_n_12 = ''; _item.trade_sector_grades_9_to_12 = '';
      _item.iron_n_folic_acid = ''; _item.deworming_tablets = ''; _item.vitamin_a_supplement = '';
      _item.mobile_number = ''; _item.email_address = ''; _item.free_bicycle = '';
      return _item;
    })
    this.setState({
      staff_Obj: _obj
    })
  }
  uploadStudentHandler = e => {
    loadProgressBar();
    e.preventDefault();
    const samiti_id = this.state.samiti_id;
    const school_id = this.state.school_id;
    const session_year = this.state.session_year;
    const _dis_continue_obj = this.state.dis_continue_students;
    let dis_continue_ids = [];
    const _new_students_obj = this.state.new_students;

    const new_students_obj = _new_students_obj.map((item) => {
      item = {
        ...item, samiti_id: samiti_id, school_id: school_id,
        session_year: session_year
      }
      return item
    })

    _dis_continue_obj.filter((item) => {
      dis_continue_ids.push({ s_id: item.s_id })
    })

    this.setState({
      new_students: new_students_obj
    }, () => {
      debugger
      console.log(JSON.stringify(new_students_obj));
      axios.post(CREATE_SUDENTS, new_students_obj)
        .then(res => {
          const getRes = res.data;
          //console.log(getRes)
          Alert.success(getRes.message, {
            position: 'bottom-right',
            effect: 'jelly',
            timeout: 5000, offset: 40
          });
        }).catch((error) => {
          //this.setState({ errorMessages: error });
        })

      console.log(JSON.stringify(dis_continue_ids));
      axios.post(DIS_CONTINUE_SUDENTS, dis_continue_ids)
        .then(res => {
          const getRes = res.data;
          //console.log(getRes)
          Alert.success(getRes.message, {
            position: 'bottom-right',
            effect: 'jelly',
            timeout: 5000, offset: 40
          });
        }).catch((error) => {
          //this.setState({ errorMessages: error });
        })

    })

  }

  componentDidMount() {
    this.setState({
      samiti_id: sessionStorage.getItem('samiti_id'),
      school_id: sessionStorage.getItem('school_id'),
      user_category: sessionStorage.getItem('user_category'),
      session_year: sessionStorage.getItem('session_year'),
    }, () => {
      this.getSchoolHandler();
      this.getStudentRecords();
      this.createDummyStudentCsv();
    })
  };

  getSchoolHandler() {
    loadProgressBar();
    const obj = {
      samiti_id: this.state.samiti_id
    }
    axios.post(READ_SCHOOLS, obj)
      .then(res => {
        const getRes = res.data;
        this.setState({
          schools_arr: getRes,
          errorMessages: getRes.message
        });
        ////console.log(this.state.classes);
      }).catch((error) => {
        // error
      })
  }
  getStudentRecords() {
    const obj = {
      samiti_id: this.state.samiti_id,
      session_year: this.state.session_year,
      user_category: this.state.user_category,
      school_id: this.state.school_id
    }
    // console.log(JSON.stringify(obj));
    axios.post(READ_CLASS_STUDENT, obj)
      .then(res => {
        const resData = res.data;
        if (resData.length > 0) {
          this.setState({
            students: resData,
            errorMessages: resData.message
          });
        }
      }).catch((error) => {
        // error
      });
  }

  render() {
    const { formIsHalfFilledOut, dis_continue_students, new_students, selected_school_index,
      schools_arr, medium_arr, medium, student_Obj, staff_Obj, dummy_stu_data } = this.state;
    console.log(this.state);
    return (
      <div className="page-content">
        <Helmet>
          <title>Upload Excel</title>
        </Helmet><Prompt when={formIsHalfFilledOut} message="Are you sure? Change Page!! If 'Yes' Your 'field DATA' will be lost..." />
        <div className="page-bar d-flex">
          <div className="page-title">Upload Student Data</div>

        </div>
        <div className="card card-box">
          <div className="card-body">
            <div className="table-scrollable">
              <div className="col-md-12 col-sm-12">
                <div className="card card-box">
                  <div>
                    {dis_continue_students.length > 0 ?
                      <div className="table-responsive">
                        <h6 className="p-2 bg-danger text-white"> Now Dis Continued Student</h6>
                        <table className="table table-striped table-bordered text-nowrap table-hover table-sm">
                          <thead>
                            <tr>
                              <th />
                              <th>STUDENT NAME</th>
                              <th>FATHER NAME</th>
                              <th>MOTHER NAME</th>
                              <th>DOB</th>
                              <th>GENDER</th>
                              <th>SOCIAL CATEGORY</th>
                              <th>ENROL NO.</th>
                              <th>CLASS</th>
                            </tr>
                          </thead>
                          <tbody>
                            {dis_continue_students.map((value, index) => {
                              return (
                                <tr key={index}>
                                  <td>{index + 1}</td>
                                  <td>{value.student_name}</td>
                                  <td>{value.father_name}</td>
                                  <td>{value.mother_name}</td>
                                  <td>{value.dob}</td>
                                  <td>{value.gender}</td>
                                  <td>{value.social_category}</td>
                                  <td>{value.admission_number}</td>
                                  <td>{value.studying_in_class}</td>
                                </tr>
                              )
                            })}
                          </tbody>
                        </table>
                      </div>
                      : null}
                    {new_students.length > 0 ?
                      <div className="table-responsive">
                        <h6 className="p-2 bg-success text-white">New Student</h6>
                        <table className="table table-striped table-bordered table-hover text-nowrap table-sm">
                          <thead>
                            <tr>
                              <th />
                              <th>STUDENT NAME</th>
                              <th>FATHER NAME</th>
                              <th>MOTHER NAME</th>
                              <th>DOB</th>
                              <th>GENDER</th>
                              <th>SOCIAL CATEGORY</th>
                              <th>ENROL NO.</th>
                              <th>CLASS</th>
                            </tr>
                          </thead>
                          <tbody>
                            {new_students.map((value, index) => {
                              return (
                                <tr key={index}>
                                  <td>{index + 1}</td>
                                  <td>{value.student_name}</td>
                                  <td>{value.father_name}</td>
                                  <td>{value.mother_name}</td>
                                  <td>{value.dob}</td>
                                  <td>{value.gender}</td>
                                  <td>{value.social_category}</td>
                                  <td>{value.admission_number}</td>
                                  <td>{value.studying_in_class}</td>
                                </tr>
                              )
                            })}
                          </tbody>
                        </table>
                      </div>
                      : null}
                    {staff_Obj.length > 0 ?
                      <div className="table-responsive">
                        <table className="table table-striped table-bordered table-hover table-sm">
                          <thead>
                            <tr>
                              <th />
                              <th>U-DISE CODE</th>
                              <th>PSP CODE</th>
                              <th>AADHAR NUMBER</th>
                              <th>STUDENT NAME</th>
                              <th>FATHER NAME</th>
                              <th>MOTHER NAME</th>
                              <th>DOB</th>
                              <th>GENDER</th>
                              <th>SOCIAL CATEGORY</th>
                              <th>RELIGION</th>
                              <th>MOTHER TONGUE</th>
                              <th>RURAL/URBAN</th>
                              <th>HABITATION OR LOCALITY</th>
                              <th>DATE OF ADMISSION</th>
                              <th>ADMISSION NUMBER</th>
                              <th>BELONG TO BPL</th>
                              <th>BELONG TO DISADVANTAGED GROUP</th>
                              <th>GETTING FREE EDUCATION</th>
                              <th>STUDYING IN CLASS</th>
                              <th>CLASS STUDIED IN PREV. YEAR</th>
                              <th>IF IN CLASS 1, STATUS OF PREVIOUS YEAR</th>
                              <th>DAYS CHILD ATTENDED SCHOOL (IN THE PREV. YEAR)</th>
                              <th>MEDIUM OF INSTRUCTION</th>
                              <th>TYPE OF DISABLITY</th>
                              <th>FACILITIES RECEIVED BY CWSN</th>
                              <th>NO. OF UNIFORM SETS</th>
                              <th>FREE TEXT BOOKS</th>
                              <th>FREE TRANSPORT</th>
                              <th>FREE ESCORT</th>
                              <th>MDM BENEFICIARY</th>
                              <th>FREE HOSTEL FACILITY</th>
                              <th>CHILD ATTENDED SPECIAL TRAINING</th>
                              <th>CHILD IS HOMELESS</th>
                              <th>APPEARD</th>
                              <th>PASSED</th>
                              <th>% MARKS</th>
                              <th>STREAM (GRADES 11 & 12)</th>
                              <th>TRADE/SECTOR (GRADES 9 TO 12)</th>
                              <th>IRON & FOLIC ACID</th>
                              <th>DEWORMING TABLETS</th>
                              <th>VITAMIN-A SUPPLEMENT</th>
                              <th>MOBILE NUMBER</th>
                              <th>EMAIL ADDRESS</th>
                              <th>FREEBICYCLE</th>
                            </tr>
                          </thead>
                          <tbody>
                            {student_Obj.map((value, index) => {
                              return (
                                <tr key={index}>
                                  <td>{index + 1}</td>
                                  <td>{value.u_dise_code}</td>
                                  <td>{value.psp_code}</td>
                                  <td>{value.aadhar_number}</td>
                                  <td>{value.student_name}</td>
                                  <td>{value.father_name}</td>
                                  <td>{value.mother_name}</td>
                                  <td>{value.dob}</td>
                                  <td>{value.gender}</td>
                                  <td>{value.social_category}</td>
                                  <td>{value.religion}</td>
                                  <td>{value.mother_tongue}</td>
                                  <td>{value.rural_urban}</td>
                                  <td>{value.habitation_or_locality}</td>
                                  <td>{value.date_of_admission}</td>
                                  <td>{value.admission_number}</td>
                                  <td>{value.belong_to_bpl}</td>
                                  <td>{value.belong_to_disadvantaged_group}</td>
                                  <td>{value.getting_free_education}</td>
                                  <td>{value.studying_in_class}</td>
                                  <td>{value.class_studied_in_prev_year}</td>
                                  <td>{value.status_of_previous_year}</td>
                                  <td>{value.days_child_attended_school}</td>
                                  <td>{value.medium_of_instruction}</td>
                                  <td>{value.type_of_disablity}</td>
                                  <td>{value.facilities_received_by_cwsn}</td>
                                  <td>{value.no_of_uniform_sets}</td>
                                  <td>{value.free_text_books}</td>
                                  <td>{value.free_transport}</td>
                                  <td>{value.free_escort}</td>
                                  <td>{value.mdm_beneficiary}</td>
                                  <td>{value.free_hostel_facility}</td>
                                  <td>{value.child_attended_special_training}</td>
                                  <td>{value.child_is_homeless}</td>
                                  <td>{value.appeard}</td>
                                  <td>{value.passed}</td>
                                  <td>{value.percentage_marks}</td>
                                  <td>{value.stream_grades_11_n_12}</td>
                                  <td>{value.trade_sector_grades_9_to_12}</td>
                                  <td>{value.iron_n_folic_acid}</td>
                                  <td>{value.deworming_tablets}</td>
                                  <td>{value.vitamin_a_supplement}</td>
                                  <td>{value.mobile_number}</td>
                                  <td>{value.email_address}</td>
                                  <td>{value.free_bicycle}</td>
                                </tr>
                              )
                            })}
                          </tbody>
                        </table>
                      </div>
                      : null}
                  </div>
                  <div className="card-body">
                    <div className="form-body">
                      <label className="control-label">Upload Student</label>
                      <div className="form-inline">
                        <div className="form-group  mr-2">
                          <label className="control-label mr-2">Schools :</label>
                          <select className="form-control form-control-sm"
                            required
                            ref='school'
                            value={selected_school_index}
                            onChange={event => this.changeHandler(event, 'school')}>
                            <option value="">Select ...</option>
                            {schools_arr.map((item, index) => {
                              return (
                                <option key={index} value={index}>{item.sch_name}, {item.sch_medium}</option>
                              )
                            })}
                          </select>
                        </div>
                        <div className="form-group mr-2">
                          <label className="control-label mr-2">Medium :</label>
                          <select className="form-control form-control-sm"
                            required
                            ref='medium'
                            disabled={medium_arr.length > 1 ? false : true}
                            value={medium}
                            onChange={event => this.changeHandler(event, 'medium')}>
                            <option value="">Select ...</option>
                            {medium_arr.map((item, index) => {
                              return (
                                <option key={index} value={item}>{item}</option>
                              )
                            })}
                          </select>
                        </div>
                        <div className="form-group  ml-auto">
                          <ExcelReader studentObjHandler={this.studentObjHandler} />
                        </div>
                      </div>
                      <div className="mt-3 d-flex">
                        <ExportCSV
                          csvData={dummy_stu_data}
                          fileName={'upload_student_data.csv'} />
                        <button type="button"
                          className="btn btn-success ml-auto mr-1"
                          disabled={(dis_continue_students.length > 0 ||
                            new_students.length > 0) ? false : true}
                          onClick={this.uploadStudentHandler}>
                          Upload
                              </button>
                        <NavLink to="#" className="btn btn-danger">Cancel</NavLink>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div >
    )
  }
}
export default withRouter(UploadExcel);