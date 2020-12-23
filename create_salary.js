import React, { Component } from 'react';
import { Prompt, withRouter } from 'react-router';
import { NavLink } from 'react-router-dom';
import { Helmet } from "react-helmet";
import { connect } from 'react-redux';
import { schoolsAction, professionalAction } from '../_actions';
import DatePicker from 'react-date-picker';
import ImageLoader from "../utility/ImageLoader/index";
import { isEmptyObj, isEmpty, isNumber } from '../utility/utilities';

import CommonFilters from '../utility/Filter/filter-schools';

class CreateSalary extends Component {
  state = {
    fee_months_arr: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'],
    due_date: new Date(),
    professional: [],
    filtered_prof: [],
    selected_month: '',
    update_prof: [],
    schools_arr: [],
    school_id: '',
    selected_school_index: '',
    medium_arr: [],
    medium: '',
    formIsHalfFilledOut: false,
  }

  changeHandler = (event, fieldName, indexValue) => {
    if (fieldName === 'monthSalary') {
      const salary = event.target.value;
      let prop = this.state.filtered_prof;
      const new_prof = prop.map((item, idx) => {
        if(idx === indexValue){
          item = {...item, salary : salary}
        }
        return item
      })
      this.setState({
        filtered_prof : new_prof 
      })
    } else {
      this.setState({
        // [fieldName]: indexValue ? event.target.checked : event.target.value,
        formIsHalfFilledOut: true
      });
    }
  };

  checkHandler = (event, fieldName, value) => {
    debugger;
    let _display_student = null;
    let _current_select = JSON.parse(value).admission_number;
    if (fieldName === 'select_this') {
      _display_student = this.state.display_student.map((checked_student) => {
        if (_current_select === checked_student.admission_number) {
          checked_student['checked'] = !checked_student.checked;
          return checked_student;
        }
        return checked_student;
      })
      this.setState({
        update_student: _display_student
      })
    } else if (fieldName === 'select_all') {
      _display_student = this.state.display_student.map((checked_student) => {
        checked_student['checked'] = (event.target.checked) ? true : false;
        return checked_student;
      })
      this.setState({
        update_student: _display_student
      })
    }
    let _update_student = _display_student.filter((checked_student) => {
      return checked_student['checked'] === true
    })
    this.setState({
      display_student: _display_student,
      update_student: _update_student
    })
  };
 
  filterProfOnDemand() {
    setTimeout(() => {
      let _proff = this.props.professional;
      const school_id = (this.refs.school.value !== '') ? this.props.schools[this.refs.school.value].id : null;
      const medium = (this.refs.medium.value !== '') ? this.refs.medium.value : null;

      //console.log('school_id ' + school_id + ' medium ' + medium + ' class_name ' + class_name);

      if (!isEmpty(school_id)) {
        _proff = _proff.filter((item) => {
          if (item.school_id === school_id) {
            return item
          }
        })
      }
      if (!isEmpty(medium)) {
        _proff = _proff.filter((item) => {
          if (item.medium === medium) {
            return item
          }
        })
      }
      this.setState({
        filtered_prof: _proff
      })
    }, 100);
  }

  componentDidMount() {
    if (isEmptyObj(this.props.schools)) {
      this.props.getSchools();
    }
    if (isEmptyObj(this.props.professional)) {
      this.props.getProfessional();
    }
    this.checkFlag();
  }


  checkFlag() {
    setTimeout(() => {
      const _filter = this.props.filteredSchoolData;
      const _all_proffessional = this.props.professional;
      if (_all_proffessional && _filter) {
        this.filterBySchoolHandler();
      } else {
        this.checkFlag()
      }
    }, 100);
  }

  filterBySchoolHandler = () => {
    const _filter = this.props.filteredSchoolData;
    const _all_proffessional = this.props.professional;

    if (!isEmpty(_all_proffessional)) {
      const _school_proffessional = _all_proffessional.filter((item) => {
        if (_filter.slct_school_id) {
          if (item.school_id === _filter.slct_school_id) {
            return item
          }
        } else {
          return item
        }
      })
      this.setState({
        filtered_prof: _school_proffessional
      })
    }
  }

  render() {
    const { filtered_prof, due_date, formIsHalfFilledOut, selected_month, fee_months_arr } = this.state;
    const { user, schools, professional } = this.props;
    console.log(this.state);
    return (
      <div className="page-content" >
        <Helmet>
          <title>Professional List</title>
        </Helmet> <Prompt when={formIsHalfFilledOut} message="Are you sure? Change Page!! If 'Yes' Your 'field DATA' will be lost..." />
        {user && schools && professional &&
          <div className="page-bar d-flex">
            <div className="page-title">Professional List</div>
            <div className="form-inline ml-auto filter-panel">
              <span className="filter-closer">
                <button type="button" className="btn btn-danger filter-toggler-c">
                  <i className="fa fa-times"></i>
                </button>
              </span>
              <div className="filter-con">
                <CommonFilters
                  showSchoolFilter={true}
                  showMediumFilter={false}
                  showClassFilter={false}
                  filterBySchoolHandler={this.filterBySchoolHandler}
                  filterByClsHandler={this.filterByClsHandler}
                />
                <div className="form-group mr-2 mt-1">
                  <label className="control-label mr-2">Month : </label>
                  <select
                    // disabled={!isEmpty(filteredClassesData.slct_cls_id) ? false : true}
                    value={selected_month - 1}
                    className="form-control form-control-sm " name="selected_month"
                    onChange={event => this.changeHandler(event, 'selected_month')}>
                    <option value="">Select...</option>
                    {fee_months_arr.map((opt, index) => {
                      return (<option key={index} value={index}>{opt}</option>)
                    })}
                  </select>
                </div>
              </div>
            </div>
          </div>
        }
        {user && schools && professional &&
          <div className="card card-box sfpage-cover">
            <div className="card-body sfpage-body">
              <div className="form-inline">
                <div className="form-group ml-auto mb-2">
                  <label className="control-label mr-2">Select Date<span className="required"> * </span>
                  </label>
                  <div className="form-input">
                    <DatePicker
                      onChange={this.startDateHandler}
                      value={due_date}
                      showLeadingZeroes={true}
                      maxDate={new Date()}
                    />
                  </div>
                </div>
              </div>
              {filtered_prof.length > 0 ?
                <div className="table-scrollable">
                  <table className="table table-striped table-bordered table-hover table-sm m-0">
                    <thead>
                      <tr>
                        <th />
                        <th>
                          <div className="custom-control custom-checkbox">
                            <input type="checkbox"
                              id="select_all" className="custom-control-input"
                              onChange={event => this.checkHandler(event, 'select_all', true)} />
                            <label className="custom-control-label" htmlFor="select_all">&nbsp;</label>
                          </div>
                        </th>
                        <th></th>
                        <th>General Information</th>
                        <th>Class Teacher</th>
                        <th>Month Salary</th>
                        <th>Remark/ Narration</th>
                      </tr>
                    </thead>
                    {filtered_prof.length > 0 ?
                      <tbody>
                        {filtered_prof.map((item, index) => {
                          return (
                            <tr key={index}>
                              <td>{index + 1}</td>
                              <td className="text-center">
                                <div className="custom-control custom-control-inline custom-checkbox">
                                  <input type="checkbox"
                                    checked={item.checked}
                                    id={`check_` + index} name="customRadio" className="custom-control-input"
                                    onChange={event => this.checkHandler(event, `select_this`, JSON.stringify(item))} />
                                  <label className="custom-control-label" htmlFor={`check_` + index}>&nbsp;</label>
                                </div>
                              </td>
                              <td className="profile-pic">
                                <NavLink to={`/edit_professional.jsp/${item.id}`} className="">
                                  {!isEmpty(item.profile_image) ?
                                    <ImageLoader
                                      src={`${process.env.PUBLIC_URL}` + item.profile_image}
                                      alt={item.emp_name}
                                      className="img-circle user-img-circle"
                                      fallbackSrc={`${process.env.PUBLIC_URL}/assets/images/dp.jpg`}
                                    />
                                    // < img src={`${process.env.PUBLIC_URL}` + item.profile_image} alt={item.emp_name} />
                                    : (item.gender === 'Male' ?
                                      <img alt="SmartPSP" src={`${process.env.PUBLIC_URL}/assets/images/prof_male.jpg`} />
                                      :
                                      <img alt="SmartPSP" src={`${process.env.PUBLIC_URL}/assets/images/prof_female.jpg`} />)
                                  }
                                </NavLink>
                              </td>
                              <td><NavLink to={`professional_profile.jsp/${item.id}`} className="">
                                {item.emp_name}
                              </NavLink> S/o <br />
                                {item.emp_f_name}<br />
                                {item.address}
                              </td>
                              <td>{item.class_teacher}</td>
                              <td><input type="number"
                                onChange={event => this.changeHandler(event, 'monthSalary', index)}
                                className="form-control form-control-sm" /></td>
                              <td><textarea 
                              onChange={event => this.changeHandler(event, 'narration', index)}
                              className="form-control form-control-sm">
                                </textarea></td>
                            </tr>
                          )
                        }
                        )}
                      </tbody>
                      : null}
                  </table>
                </div>
                : null}
            </div>
            <div className="card-footer text-right">
              <button type="button"
                onClick={event => this.confirmBoxSubmit(event)}
                className="btn btn-primary btn-sm mr-2">Update</button>
            </div>
          </div>
        }
      </div >
    )
  }
}

function mapStateToProps(state) {
  const { item: user } = state.authentication;
  const { item: schools } = state.schools;
  const { item: professional } = state.professional;
  const filteredSchoolData = state.filteredSchoolData;
  return { user, schools, professional, filteredSchoolData };
}

const actionCreators = {
  getSchools: schoolsAction.getSchools,
  getProfessional: professionalAction.getProfessional,
}

export default connect(mapStateToProps, actionCreators)(withRouter(CreateSalary));
