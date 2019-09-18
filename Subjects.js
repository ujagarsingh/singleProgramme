import React, { Component } from 'react';
import { NavLink } from 'react-router-dom';

class AddSubject extends Component {
  state = {
    classes: [],
    class_id: 0,
    sub_lavel: [{ sub_lavel: "1" }, { sub_lavel: "2" }],
    existsubject: [{ sub_name: "", sub_lavel: "1" }],
    subjectnames: [{ sub_name: "", sub_lavel: "1", sub_p: [] }],
    errorMessages: '',
    successMessages: ''
  }
  handleSubNameHandler = index => evt => {
    const _newItem = this.state.subjectnames.map((item, sidx) => {
      if (index !== sidx) return item;
      return { ...item, sub_name: evt.target.value, sub_lavel: "1" };
    });
    this.setState({ subjectnames: _newItem });
  };
  handleSubLavelHandler = index => evt => {
    const _newItem = this.state.subjectnames.map((item, sidx) => {
      if (index !== sidx) return item;
      if (evt.target.value == 2) {
        return {
          ...item,
          sub_lavel: evt.target.value,
          sub_p: [{ sub_name: "", sub_lavel: "1", sub_p: [] }]
        };
      } else {
        return {
          ...item,
          sub_lavel: evt.target.value,
          sub_p: []
        };
      }
    });
    this.setState({ subjectnames: _newItem });
  };
  handleAddSubject = () => {
    this.setState({
      subjectnames: this.state.subjectnames.concat([{ sub_name: "", sub_lavel: "1", sub_p: [] }])
    });
  };
  handleRemoveSubject = index => () => {
    if (this.state.subjectnames.length > 1) {
      this.setState({
        subjectnames: this.state.subjectnames.filter((s, sidx) => index !== sidx)
      })
    }
  };



  /** */
  handleSubNameHandler_1 = index => evt => {
    const _newItem = this.state.subjectnames.map((item, sidx) => {
      if (index !== sidx) return item;
      return { ...item, sub_name: evt.target.value, sub_lavel: "1" };
    });
    this.setState({ subjectnames: _newItem });
  };
  handleSubLavelHandler_1 = index => evt => {
    const _newItem = this.state.subjectnames.map((item, sidx) => {
      if (index !== sidx) return item;
      if (evt.target.value == 2) {
        return {
          ...item,
          sub_lavel: evt.target.value,
          sub_p: [{ sub_name: "", sub_lavel: "1", sub_p: [] }]
        };
      } else {
        return {
          ...item,
          sub_lavel: evt.target.value,
          sub_p: []
        };
      }
    });
    this.setState({ subjectnames: _newItem });
  };
  handleAddSubject_1 = () => {
    this.setState({
      subjectnames: this.state.subjectnames.concat([{ sub_name: "", sub_lavel: "1", sub_p: [] }])
    });
  };
  handleRemoveSubject_1 = index => () => {
    if (this.state.subjectnames.length > 1) {
      this.setState({
        subjectnames: this.state.subjectnames.filter((s, sidx) => index !== sidx)
      })
    }
  };
  /* */

  getSectedClassHandler = (event) => {
    const _class_id = event.target.value;
    //this.subjectsClasswise(_class_id);
  }


  submitHandler = e => {
    const _state = this.state;
    e.preventDefault();
    const _subject = _state.subjectnames.filter((item, index) => {
      return item.sub_name.length > 0
    })
    const obj = {
      class_id: _state.class_id,
      sub_name: _subject
    };
    console.log(JSON.stringify(obj));
  };
  render() {
    const _state = this.state;
    console.log(_state);
    return (
      <form className="form-horizontal" onSubmit={this.submitHandler}>
        <div className="form-body">
          <div className="form-group row">
            <label className="control-label col-md-3">Subject Name
		<span className="required"> * </span>
            </label>
            <div className="col-md-6">
              {(_state.subjectnames.length > 0) ? _state.subjectnames.map((item, index) => (
                <div className="form-group" key={index}>
                  <div className="form-group">
                    <div className="input-group mb-3">
                      <div className="input-group-prepend">
                        <button
                          type="button"
                          className="btn btn-danger"
                          onClick={this.handleRemoveSubject(index)} >
                          <i className="fa fa-minus"></i>
                        </button>
                      </div>
                      <input
                        type="text"
                        className="form-control"
                        placeholder={`#${index + 1} `}
                        value={item.sub_name}
                        onChange={this.handleSubNameHandler(index)}
                      />
                      <select className="form-control" name="sub_lavel"
                        value={item.sub_lavel}
                        onChange={this.handleSubLavelHandler(index)}>
                        {_state.sub_lavel.map((option, index) => {
                          return (
                            <option key={index}>
                              {option.sub_lavel}
                            </option>
                          )
                        })}
                      </select>
                      <div className="input-group-append">
                        <button
                          type="button"
                          className="btn btn-info"
                          onClick={this.handleAddSubject}
                        >
                          <i className="fa fa-plus"></i>
                        </button>
                      </div>
                    </div>
                  </div>
                  {(item.sub_p.length > 0) ? item.sub_p.map((item, index_1) => {
                    return (
                      <div key={index_1} className="form-group row">
                        <label className="control-label col-md-3">Part <span className="required"> * </span>
                        </label>
                        <div className="col-md-9">
                          <div className="form-group">
                            <div className="input-group mb-3">
                              <div className="input-group-prepend">
                                <button
                                  type="button"
                                  className="btn btn-danger"
                                  onClick={this.handleRemoveSubject_1(index_1)} >
                                  <i className="fa fa-minus"></i>
                                </button>
                              </div>
                              <input
                                type="text"
                                className="form-control"
                                placeholder={`#${index_1 + 1} `}
                                value={item.sub_name}
                                onChange={this.handleSubNameHandler_1(index_1)}
                              />
                              <select className="form-control" name="sub_lavel"
                                value={item.sub_lavel}
                                onChange={this.handleSubLavelHandler_1(index_1)}>
                                {_state.sub_lavel.map((option, index_1) => {
                                  return (
                                    <option key={index_1}>
                                      {option.sub_lavel}
                                    </option>
                                  )
                                })}
                              </select>
                              <div className="input-group-append">
                                <button
                                  type="button"
                                  className="btn btn-info"
                                  onClick={this.handleAddSubject_1(index_1)}
                                >
                                  <i className="fa fa-plus"></i>
                                </button>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                    )
                  }) : null}
                </div>
              )) : null}
            </div>
          </div>
        </div>
        <ul>
          {_state.subjectnames.map((item, index) => {
            return (
              <li key={index}>{item.sub_name}</li>
              <ul>
                {item.sab_p.map((item, index) => {
                  return (
                    <li key={index}> {item.sub_name} </li>
                  )
                })}
              </ul>
            )
          })}
        </ul>
      </form>

    )
  }
}
export default AddSubject;

