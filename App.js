SELECT YEAR(date), MONTHNAME(date), SUM(credit) 
FROM income
GROUP BY YEAR(date), MONTH(date);

import React, { Component } from 'react';
import Sidebar from './Sidebar';
import ListItem from './ListItem'

class AboutMe extends Component {
	state = {
		month: [
			{ 'id': 101, 'name': 'January' },
			{ 'id': 102, 'name': 'February' },
			{ 'id': 103, 'name': 'March' },
			{ 'id': 104, 'name': 'April' }],
		dataObj: []
	}
	counter(id) {
		alert(`i am work ${id}`)
	}
	render() {
		return (
			<div className="container">
				<div className="row">
					<div className="col-sm-4">
						<Sidebar />
					</div>
					<div className="col-sm-8 xsy">
						<h2 >About Me</h2>
						<ol>
							{this.state.month.map((item, inx) => {
								return (
									<ListItem
										key={inx}
										index={inx}
										item={item}
										fun={this.counter}
									/>
								)
							})}
						</ol>
					</div>
				</div>

			</div>
		);
	}
}

export default AboutMe;


import React, { Component } from 'react';
class ListItem extends Component {
    state = {
        index: '',
        item: ''
    }
    componentDidMount() {
        this.setState({
            index: this.props.index,
            item: this.props.item,
        })
    }
    counter(id) {
        this.props.fun(id)
    }
    render() {
        const mystyle = { 'page-break-inside': 'avoid' }
        return (
            <li style={mystyle} key={this.state.index}>{this.state.item.name}<br />
                <p>Lorem Ipsum </p>
                <button className="btn btn-primary" onClick={event => this.counter(this.state.item.id)}>Click</button>
                <br />
            </li>
        );
    }
}

export default ListItem;
