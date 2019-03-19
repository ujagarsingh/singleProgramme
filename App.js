import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';
import { withAlert } from 'react-alert'

import  CheckBox  from './checkbox';
nums: {
  bool: {
    TRUE: true;
    FALSE: false;
  }
  children: [
    { value: 1, label: "On its way" },
    { value: 2, label: "Newborn to 2 years" },
    { value: 4, label: "2 to 6 years" },
    { value: 8, label: "7 to 11 years" },
    { value: 16, label: "12 to 15 years" },
    { value: 32, label: "16 to 18 years" },
    { value: 64, label: "19 and older" }
  ];
}
class App extends Component {
  state={
    counter : 1,
	radioOpt : 'option1',
	fruites: [
        {id: 1, value: "banana", isChecked: false},
        {id: 2, value: "apple", isChecked: false},
        {id: 3, value: "mango", isChecked: false},
        {id: 4, value: "grap", isChecked: false}
      ]
	
  }
  incCounter = () => {
    this.setState({
      counter : this.state.counter + 1
    })
  }
  handleOptionChange = ((event) => {
	this.setState({
		radioOpt: event.target.value
	  });
  })

  
  handleFormSubmit = ((event) =>{
	  event.preventDefault();
	  console.log(this.state)
  } )

  handleChange = ((key) => {
    return function(e) {
      var state = {};
      state[key] = e.target.value;
      this.setState(state);
    }.bind(this);
  })
  
  render() {
    return (
      <div className="App">
         <h1>Welcome in MyApp</h1>
         <h2>{this.state.counter}</h2>
         <button onClick={this.incCounter}>+</button>
         {/* <button
          onClick={() => {
            this.props.alert.success('Oh look, an alert!')
          }}
        >
          Show Alert
        </button> */}
		<hr />
		<form onSubmit={this.handleFormSubmit}>
    <div className="radio">
      <label>
        <input type="radio" value="option1" 
			  checked={this.state.radioOpt === 'option1'} 
			  onChange={this.handleOptionChange} />
        Option 1
      </label>
    </div>
    <div className="radio">
      <label>
        <input type="radio" value="option2" 
			  checked={this.state.radioOpt === 'option2'} 
			  onChange={this.handleOptionChange} />
        Option 2
      </label>
    </div>
    <div className="checkbox">
      <label>
        <input type="checkbox" value="option3" 
			  checked={this.state.radioOpt === 'option3'} 
			  onChange={this.handleOptionChange} />
        Option 3
      </label>
    </div>
	<h2> radioOpt : {this.state.radioOpt}</h2>
	
  <CheckBoxGroup
  formGroup={this.enums.bool.TRUE}
  name="children"
  label="Do you have children? If so, check all that apply."
  state={this.state}
  handleChange={this.handleChange("children")}
  items={this.enums.children}
/>
	 
	<button type="submit">Submit</button>
  </form>
      </div>
    );
  }
}

export default withAlert(App);
