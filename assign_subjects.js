import React, { Component } from 'react';
import { Prompt, withRouter } from 'react-router';
import { NavLink } from 'react-router-dom';
import axios from 'axios';
import { loadProgressBar } from 'axios-progress-bar';
import Alert from 'react-s-alert';
//import { confirmAlert } from 'react-confirm-alert';
import { Helmet } from "react-helmet";
//import { HOST_URL } from '../includes/api-config';

const VALIDATE_URL = `http://www.rajpsp.com/api/login/validate_token.php`;
const READ_SCHOOLS = `http://www.rajpsp.com/api/school/read.php`;
const READ_URL = `http://www.rajpsp.com/api/subject/read.php`;
const READ_CLASS_URL = `http://www.rajpsp.com/api/classes/read.php`;
const DELETE_URL = `http://www.rajpsp.com/api/subject/delete.php`;

class AssignSubjects extends Component {
   state = {
      schools_arr: [],
      school_id: '',
      selected_school_index: '',
      medium_arr: [],
      subjects: [],
      selected_subjects: [],
      sft_classes: [],
      selected_class: '',
      selected_class_inx: '',
      selected_classes: [],
      medium: '',
      errorMessages: '',
      successMessages: '',
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
         this.filterClassesOnSchool(_sch_id, this.state.group_id);
         this.setState({
            school_id: _sch_id,
            medium_arr: _medium,
            medium: (_medium.length === 1 ? _medium[0] : ''),
            selected_school_index: _inx,
            selected_class_inx: '',
            selected_subjects: []
         })
      } else if (fieldName === 'medium') {
         const _medium = event.target.value;
         sessionStorage.setItem("medium", _medium);
      } else if (fieldName === 'selected_class') {
         const _class_inx = event.target.value;
         const _class_name = this.state.selected_classes[_class_inx].class_name_portal;
         //console.log(this.state.selected_classes[_class_inx]);
         sessionStorage.setItem("class_name_portal", _class_name);
         this.classHandler(_class_inx);
         this.setState({
            [fieldName]: isCheckbox ? event.target.checked : event.target.value,
            selected_class_inx: _class_inx
         })
      } else {
         this.setState({
            [fieldName]: isCheckbox ? event.target.checked : event.target.value
         })
      }
   };
   filterClassesOnSchool(sch_id, group_id) {
      const _classes = this.state.sft_classes.filter((item) => {
         if (item.group_id === group_id && item.school_id === sch_id) {
            return item
         }
      })
      this.setState({
         selected_classes: _classes,
      }, ()=>{this.schoolWiseClassAndSubjectHandler()})
   }
   schoolWiseClassAndSubjectHandler(){
     const class_arr = this.state.selected_classes;
     const subject_arr = this.state.selected_subjects;
     const classWiseSubjectObj = "";

   }
   classHandler(_classIdx) {
      const { subjects, medium, selected_classes } = this.state
      if (_classIdx !== 'All') {
         const _class_name = selected_classes[_classIdx].class_name;
         const _class_id = selected_classes[_classIdx].id;
         const _subject = subjects.filter((item, inx) => {
            if (item.medium === medium && item.class_id === _class_id) {
               return item
            }
         })
         this.setState({
            selected_subjects: _subject
         })
      } else {
         const _subject = subjects.filter((item, inx) => {
            if (item.medium === medium) {
               return item
            }
         })
         this.setState({
            selected_subjects: _subject
         })
      }
   }
   basicInfoHandler = (event) => {
      event.preventDefault();
      this.setState({
         basicInfo: !this.state.basicInfo
      })
   }
   componentDidMount() {
      const token = sessionStorage.getItem('jwt');
      const obj = { "jwt": token };
      this.checkAuthentication(obj);
   }

   checkAuthentication(obj) {
      loadProgressBar();
      axios.post(VALIDATE_URL, obj)
         .then(res => {
            const getRes = res.data;
            // sessionStorage.setItem("user", getRes.data);
            console.log(getRes);
            if (getRes.data) {
               this.setState({
                  user: getRes.data,
                  group_id: (getRes.data.group_id) ? getRes.data.group_id : "",
                  school_id: (getRes.data.school_id) ? getRes.data.school_id : "",
                  user_category: (getRes.data.user_category) ? getRes.data.user_category : "",
                  session_year: (getRes.data.session_year) ? getRes.data.session_year : "",
               }, () => {
                  this.getSchoolHandler();
                  this.getSubjectsHandler();
                  this.getClassesHandler();
               })
            }
         }).catch((error) => {
            this.props.history.push('/login.jsp');
         })
   }

   getSchoolHandler() {
      loadProgressBar();
      const obj = {
         group_id: this.state.group_id
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
   getSubjectsHandler() {
      loadProgressBar();
      axios.get(READ_URL)
         .then(res => {
            const resData = res.data;
            if (resData.message !== undefined) {
               Alert.error(resData.message, {
                  position: 'bottom-right',
                  effect: 'jelly',
                  timeout: 5000,
               });
            } else {
               if (this.state.user_category === "1") {
                  this.setState({
                     subjects: resData,
                  }, () => { this.finalSubArray() });
               } else {
                  this.setState({
                     subjects: resData,
                     selected_subjects: resData,
                  }, () => { this.finalSubArray() });
               }
            }
         }).catch((error) => {
            // error
         })
   };
   getClassesHandler() {
      loadProgressBar();
      const obj = {
         group_id: this.state.group_id,
         school_id: this.state.school_id,
         user_category: this.state.user_category,
         session_year: this.state.session_year,
      }
      // console.log(JSON.stringify(obj));
      axios.post(READ_CLASS_URL, obj)
         .then(res => {
            const classes = res.data;
            if (this.state.user_category === "1") {
               this.setState({
                  sft_classes: classes,
                  errorMessages: res.data.message
               }, () => { this.finalSubArray() });
            } else {
               this.setState({
                  sft_classes: classes,
                  selected_classes: classes,
                  errorMessages: res.data.message
               }, () => { this.finalSubArray() });
            }
            //console.log(this.state.classes);
         })
         .catch((error) => {
            // error
         });
   };
   finalSubArray = () => {
      const _subjects_arr = this.state.subjects;
      if (!this.isEmpty(_subjects_arr)) {
         const _subjects = _subjects_arr.map((item, index) => {
            let _class_name = '';
            this.state.sft_classes.filter((item_c, index) => {
               if (item.class_id === item_c.id) {
                  _class_name = item_c.class_name
               }
            })
            return item = { ...item, class_name: _class_name }
         })
         this.setState({
            subjects: _subjects
         })
      }
   }
   deleteHandlar = (event) => {
      event.preventDefault();
      const _id = event.target.value;
      axios.post(DELETE_URL + '?id=' + _id)
         .then(res => {
            const getRes = res.data;
            //console.log(getRes)
            Alert.success(getRes.message, {
               position: 'bottom-right',
               effect: 'jelly',
               timeout: 5000, offset: 40
            });
            const _subjects = this.state.selected_subjects.filter((item, index) => {
               return item.id !== _id
            })
            this.setState({
               selected_subjects: _subjects
            })
         }).catch((error) => {
            //this.setState({ errorMessages: error });
         })
   }
   render() {
      const { selected_school_index, schools_arr, selected_classes, medium_arr, selected_subjects,
         medium, selected_class_inx, user } = this.state;
      console.log(JSON.stringify(this.state))
      return (
         <div className="page-content">
            <Helmet>
               <title>All Subject</title>
            </Helmet>
            {user &&
               <>
                  <div className="page-bar d-flex">
                     <div className="page-title">Subjects List</div>
                     <div className="form-inline ml-auto filter-panel">
                        <span className="filter-closer">
                           <button type="button" className="btn btn-danger filter-toggler-c">
                              <i className="fa fa-times"></i>
                           </button>
                        </span>
                        <div className="filter-con">
                           {user.user_category === "1" ?
                              <div className="form-group mr-2 mt-1">
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
                              : null}
                           <div className="form-group mr-2 mt-1">
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
                           <div className="form-group mr-2 mt-1">
                              <label className="control-label mr-2">Class : </label>
                              <select
                                 // disabled={medium === '' ? true : false}
                                 value={selected_class_inx}
                                 className="form-control form-control-sm " name="selected_class"
                                 onChange={event => this.changeHandler(event, 'selected_class')}>
                                 <option value="All">Select...</option>
                                 {selected_classes.map((option, index) => {
                                    return (<option key={index} value={index}>{option.class_name}</option>)
                                 })}
                              </select>
                           </div>
                           <div className="form-group mt-1">
                              <NavLink to="/add_subject.jsp" className="btn btn-primary btn-sm">
                                 Add New <i className="fa fa-plus" />
                              </NavLink>
                           </div>
                        </div>
                     </div>
                  </div>
                  <div className="card card-box sfpage-cover">
                     <div className="card-body sfpage-body">
                        <div className="table-scrollable">
                           <table className="table table-striped table-sm table-bordered table-hover table-sm">
                              <thead>
                                 <tr>
                                    <th>Id</th>
                                    <th>Class Name</th>
                                    {/* <th>Subject Lavel</th> */}
                                    <th>Subject Name</th>
                                    <th>Action</th>
                                 </tr>
                              </thead>
                              {selected_subjects.length > 0 ?
                                 <tbody>
                                    {selected_subjects.map((item, index) => {
                                       return (
                                          <tr key={index}>
                                             <td>{index + 1}</td>
                                             <td>{item.class_name}</td>
                                             {/* <td><span className={(item.sub_lavel > 2) ? 'pl-4' : 'pl-0'}>{item.sub_lavel}</span></td> */}
                                             <td><span className={(item.sub_lavel > 2) ? 'pl-4' : 'pl-0'}>{item.sub_name}</span></td>
                                             <td>
                                                {/*<NavLink to={`/edit_subject.jsp/${item.class_id}`} className="btn btn-primary btn-sm">
                                          Edit
                                       </NavLink>
                              */}
                                                <button className="btn btn-danger btn-sm"
                                                   value={item.id}
                                                   type="button"
                                                   onClick={event => this.deleteHandlar(event)}>
                                                   Delete
                          </button>
                                             </td>
                                          </tr>
                                       )
                                    })}
                                 </tbody>
                                 : null}
                           </table>
                        </div>
                     </div>
                  </div>
               </>
            }
         </div>
      )
   }
}
export default withRouter(AssignSubjects);