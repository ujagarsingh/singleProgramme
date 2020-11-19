import React, { Component } from 'react';
import { withRouter } from 'react-router';
// import { NavLink } from 'react-router-dom';
import { Helmet } from "react-helmet";
import { connect } from 'react-redux';
import { accLedgerActions, accGroupActions, accLedgerEntryActions, studentsAction, schoolsAction, classesAction } from '../_actions';
import { isEmptyObj, isEmpty, balanceSheetHandler } from '../utility/utilities';


import CommonFilters from '../utility/Filter/filter-schools';

class BalanceSheet extends Component {

  state = {
    formIsHalfFilledOut: false,
  }

  componentDidMount() {
    if (isEmptyObj(this.props.schools)) {
      this.props.getSchools();
    }
    if (isEmptyObj(this.props.classes)) {
      this.props.getClasses();
    }
    if (isEmptyObj(this.props.accLedgerEntry)) {
      this.props.getAccLedgerEntry();
    }
    if (isEmptyObj(this.props.accLedger)) {
      this.props.getAccLedger();
    }
    if (isEmptyObj(this.props.accGroup)) {
      this.props.getAccGroup();
    }
    if (isEmptyObj(this.props.students)) {
      this.props.getStudents();
    }
    this.checkFlag();
  }


  checkFlag() {
    setTimeout(() => {
      const _filter = this.props.filteredSchoolData;
      const _all_student = this.props.students;
      const _accGroup = this.props.accGroup;
      const _accLedgerEntry = this.props.accLedgerEntry;
      if (_all_student && _filter && _accGroup && _accLedgerEntry) {
        this.filterBySchoolHandler();
      } else {
        this.checkFlag()
      }
    }, 100);
  }

  filterBySchoolHandler = () => {
    const _filter = this.props.filteredSchoolData;
    const _all_student = this.props.students;
    if (!isEmpty(_all_student)) {
      const _school_student = _all_student.filter((item) => {
        if (_filter.slct_school_id) {
          if (item.school_id === _filter.slct_school_id) {
            return item
          }
        } else {
          return item
        }
      })
      this.setState({
        display_student: _school_student,
      }, () => this.filterByClsHandler())
    }
  }

  filterByClsHandler = () => {
    const _fltr_school = this.props.filteredSchoolData;
    const _fltr_class = this.props.filteredClassesData;
    const _all_student = this.props.students;
    if (_all_student) {
      const _school_student = _all_student.filter((item) => {
        if (!isEmpty(_fltr_class.slct_cls_name)) {
          if (item.school_id === _fltr_school.slct_school_id &&
            item.stu_class === _fltr_class.slct_cls_name) {
            return item
          }
        } else {
          if (item.school_id === _fltr_school.slct_school_id) {
            return item
          }
        }
      })
      if(_school_student.length > 0){
        this.setState({
          display_student: _school_student
        },() => this.getFinalDataHandler() )
      } 
    }
  }

  getFinalDataHandler() {
    const res_data = this.props.accLedgerEntry;
    const res_students = this.state.display_student;
    let ldr_data = [];
    res_data.map((ldrs) => {
      // let ldr_with_details = [];
      const _newLdr = ldrs.ledgers.map((kItem) => {
        const lr_ref = kItem.ldr_ref_id.split("_");

        switch (lr_ref[1]) {
          case 'STU':
            // Students
            const ldr_info = res_students.filter((sItem) => {
              if (lr_ref[0] === sItem.se_id && lr_ref[2] === sItem.school_id) {
                return sItem;
              }
            })
            kItem = { ...kItem, "ldr_name": ldr_info[0].student_name + ' S/o ' + ldr_info[0].father_name + ' [Enroll : ' + ldr_info[0].admission_number + ']' + ' [Class : ' + ldr_info[0].stu_class + ']' }
            break;
          case 'STF':
            // Staff

            break;
          default:
            // Other Ledgers
            const ldr_info1 = res_students.filter((sItem) => {
              if (lr_ref[0] === sItem.se_id && lr_ref[2] === sItem.school_id) {
                return sItem;
              }
            })
            kItem = { ...kItem, "ldr_name": ldr_info1[0].ledger_name }
        }
        return kItem;
      })
      ldr_data = [...ldr_data, ..._newLdr];
    });
    // return ldr_data;
    this.setState({
      ldr_data: ldr_data,
      balance_res: balanceSheetHandler(ldr_data, this.props.accGroup)
    })
    
  }

  getGroupwiseDetail = (group_title, group_id) => {
    const _blanceData = this.state.balance_res;
    const _crnt_grp = _blanceData.filter((item) => {
      if (item.id === group_id) {
        return item
      }
    });
    const g_total = _crnt_grp[0].final_balance;
    let parent_row = <div className="bs-detail-head">
                      <div className="head-name">{group_title}</div>
                      <div className="head-amount">{(g_total === 0) ? '' : g_total}</div>
                    </div>;
    let child_rows = _crnt_grp[0].sub_group.map((item) => {
      const sub_total = item.final_balance;
      return (
        <div className="bs-detail-sub-head">
          <div className="sub-head-name">{item.group_name}</div>
          <div className="sub-head-amount">{(sub_total === 0) ? '' : sub_total}</div>
        </div>
      )
    });
    const abc = <div className="bs-detail-zone">{parent_row} {child_rows}</div>;
    return abc;
  }

  render() {
    const { display_student, class_section, balance_res } = this.state;
    const { user, students, schools, filteredSchoolData } = this.props;
    console.log(this.props)
    return (
      <div className="page-content">
        <Helmet>
          <title>Balance Sheet</title>
        </Helmet>
        {(user && students && schools) &&
          <div className="page-bar d-flex">
            <div className="page-title">Balance Sheet</div>
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
                  showClassFilter={true}
                  filterBySchoolHandler={this.filterBySchoolHandler}
                  filterByClsHandler={this.filterByClsHandler}
                />
              </div>
            </div>
          </div>
        }
        { balance_res &&
          <div className="card card-box sfpage-cover">
            <div className="card-body p-1 sfpage-body">
              <div className="acc-page acc-midline page-balance-sheet">
                <div className="acc-page-head container-fluid ">
                  <div className="row">
                    <div className="col-sm-6">
                      <div className="sec-title">
                        <div className="title-zone">Liabilities</div>
                        <div className="info-zone">
                          <div className="org-name">{filteredSchoolData.slct_school.sch_name}</div>
                          <div className="fy-detail">as at 1-Jul-2020</div>
                        </div>
                      </div>
                    </div>
                    <div className="col-sm-6">
                      <div className="sec-title">
                        <div className="title-zone">Assets</div>
                        <div className="info-zone">
                          <div className="org-name">{filteredSchoolData.slct_school.sch_name}</div>
                          <div className="fy-detail">as at 1-Jul-2020</div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div className="acc-page-body container-fluid ">
                  <div className="row">
                    <div className="col-sm-6">
                      {this.getGroupwiseDetail('Capital Account', "5")}
                      <div className="bs-detail-zone">
                        <div className="bs-detail-head">
                          <div className="head-name">Loans (Liability)</div>
                          <div className="head-amount"></div>
                        </div>
                        <div className="bs-detail-sub-head"></div>
                      </div>
                      {this.getGroupwiseDetail('Current Liabilities', "4")}
                      <div className="bs-detail-zone">
                        <div className="bs-detail-head">
                          <div className="head-name">Excess of income over expenditure (P&L)</div>
                          <div className="head-amount">9,450.00</div>
                        </div>
                        <div className="bs-detail-sub-head">
                          <div className="sub-head-name">Opening Balance</div>
                          <div className="sub-head-amount">6,750.00</div>
                        </div>
                        <div className="bs-detail-sub-head">
                          <div className="sub-head-name">Current Period</div>
                          <div className="sub-head-amount">2,700.00</div>
                        </div>
                      </div>
                    </div>

                    <div className="col-sm-6">
                        {this.getGroupwiseDetail('Current Assets', "3")}
                    </div>
                  </div>
                </div>
                <div className="acc-page-footer container-fluid ">
                  <div className="row">
                    <div className="col-sm-6">
                      <div className="sec-foot">
                        <div className="title-zone">Total</div>
                        <div className="amount-zone">9,450.00</div>
                      </div>
                    </div>
                    <div className="col-sm-6">
                      <div className="sec-foot">
                        <div className="title-zone">Total</div>
                        <div className="amount-zone">9,450.00</div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        }
      </div >
    )
  }
}

function mapStateToProps(state) {
  const { item: user } = state.authentication;
  const filteredSchoolData = state.filteredSchoolData;
  const filteredClassesData = state.filteredClassesData;
  const { item: schools } = state.schools;
  const { item: students } = state.students;
  const { item: accLedger } = state.accLedger;
  const { item: accGroup } = state.accGroup;
  const { item: accLedgerEntry } = state.accLedgerEntry;
  return {
    user, students, accLedger, accGroup, accLedgerEntry, schools,
    filteredSchoolData, filteredClassesData
  };
}

const actionCreators = {
  getSchools: schoolsAction.getSchools,
  getClasses: classesAction.getClasses,
  getStudents: studentsAction.getStudents,
  getAccLedger: accLedgerActions.getAccLedger,
  getAccGroup: accGroupActions.getAccGroup,
  getAccLedgerEntry: accLedgerEntryActions.getAccLedgerEntry,

}

export default connect(mapStateToProps, actionCreators)(withRouter(BalanceSheet));
