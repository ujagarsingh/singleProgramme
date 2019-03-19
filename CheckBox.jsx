var React = require("react");
module.exports = React.createClass({
  checked: checked,
  render: render
});
function checked() {
  var val = this.props.state[this.props.name];
  return val & this.props.value;
}
function render() {
  if (this.props.formGroup === true) {
    return (
      <div>
        <input
          type="checkbox"
          className="form - control"
          name={this.props.name}
          onChange={this.props.handleChange}
          value={this.props.value}
          checked={this.checked()}
        />
        <span> {this.props.label} </span>
      </div>
    );
  }
}