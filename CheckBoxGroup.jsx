var React = require("react");
var CheckBox = require("./CheckBox.jsx");
module.exports = React.createClass({
  handleChange: handleChange,
  render: render
});
function handleChange(e) {
  var val = parseInt(e.target.value);
  if (this.props.state[this.props.name] >= 0) {
    if (e.target.checked) {
      val = val | this.props.state[this.props.name];
    } else {
      val = val ^ this.props.state[this.props.name];
    }
  }
  e.target.value = val;
  this.props.handleChange(e);
}
function render() {
  var _this = this;
  var props = this.props;
  if (this.props.formGroup === true) {
    return (
      <div className="form-group">
        <label htmlFor={this.props.name}>{this.props.label}</label>
        {this.props.items.map(function(item, idx) {
          return (
            <CheckBox
              formGroup={props.formGroup}
              name={props.name}
              label={item.label}
              value={item.value}
              state={props.state}
              handleChange={_this.handleChange}
              key={props.name + "." + idx}
            />
          );
        })}
      </div>
    );
  }
}