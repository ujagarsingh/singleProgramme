function sidebarFunction() {
            var toggler = document.getElementsByClassName("nav-toggle");
            var i;
            for (i = 0; i < toggler.length; i++) {
                toggler[i].addEventListener("click", function() {
                    var _sidebar = this.parentElement.parentElement.classList.contains('sidemenu');


                    if (this.classList.contains('active')) {
                        if (this.classList.contains('nav-toggle')) {
                            this.classList.remove('active');
                            this.nextElementSibling.classList.remove('active');
                            this.parentElement.classList.remove('active');
                            var _activeLinks = Array.prototype.slice.call(this.nextElementSibling.getElementsByClassName("active"));
                            _activeLinks.forEach(function(item, index) {
                                item.classList.remove('active');
                            })
                        }


                        var _arrow = Array.prototype.slice.call(this.getElementsByClassName('arrow'));
                        if (_arrow.length > 0) {
                            _arrow.forEach(function(item, index) {
                                item.classList.remove('open');
                            })
                        }

                    } else {
                        var _activeSibling = Array.prototype.slice.call(this.parentElement.parentElement.getElementsByClassName("active"));
                        if (_activeSibling.length > 0) {
                            _activeSibling.forEach(function(item, index) {
                                item.classList.remove('active');
                            });
                        }

                        var _activePreSibling = Array.prototype.slice.call(this.parentElement.parentElement.parentElement.getElementsByClassName("active"));
                        if (_activePreSibling.length > 0) {
                            _activePreSibling.forEach(function(item, index) {
                                item.classList.remove('active');
                            });
                        }


                        if (this.classList.contains('nav-toggle')) {
                            this.classList.add('active');
                            this.nextElementSibling.classList.add('active');
                            this.parentElement.classList.add('active');

                            var _arrow = Array.prototype.slice.call(this.getElementsByClassName('arrow'));
                            if (_arrow.length > 0) {
                                _arrow.forEach(function(item, index) {
                                    item.classList.add('open');
                                })
                            }
                        }
                    }
                });
            }
        }

function funFixedHeader(element){
	//alert(1);
	if($(window).width() >= 768){
	var _this = element;
	//$('.covermaster').prop("style")["width"] == ''
	setTimeout(function(){
		var _table = $($(_this).children('table'))[0];
		var _thead = $($(_table).children('thead'))[0];
		var _tbody = $($(_table).children('tbody'))[0];
		var _mst = $(_this).closest('.masterdivAny');
		var _mdh = $(_mst).outerHeight();
		var _mdw = $(_table).outerWidth();
		var _tblH = $(_table).outerHeight();
		var _tWidth = $(_table).outerWidth();
		var _extClass = $(_table).attr('class');

		var _div_header = document.createElement("div");
		$(_div_header).css({'position':'absolute','z-index': '50', 'text-align': 'center', 'width':'100%', 'overflow-y':'scroll'}); //'min-width':_tWidth+'px',
		$(_div_header).addClass('nagasaki');
		var _table_header = document.createElement("table");
		$(_table_header).css({'width':'100%'});
	    $(_table_header).addClass(_extClass);
		$(_table_header).append($(_thead).clone());
		$(_div_header).append($(_table_header));
		$(_this).prepend($(_div_header));
		
		var _div_table = document.createElement("div");
		$(_div_table).css({'position':'relative','height':_mdh+'px', 'display':'flex', 'overflow-y':'scroll','overflow-x': 'hidden', 'width':'100%'}); //'min-width':_mdw+'px', 'padding-bottom': '20px',  
		$(_div_table).addClass('hiroshima');
		$(_table).css({ 'width':'100%', 'top': '25px!important', }); // 'min-width':_mdw-20+'px',
		$(_div_table).append(_table);
		$(_this).append($(_div_table));
		
		$(_this).css({'position':'relative', 'overflow-y':'hidden', 'overflow-x':'auto', 'width':'100%','height':_mdh+'px'}); // 'min-width':_mdw+'px', 
		$(_mst).css({'overflow':'auto hidden'}); // 'min-width':_mdw+'px',
		/*scroll start*/
		var _div_scroll = document.createElement("div");
		$('.gridScroll').remove();
		$(_div_scroll).addClass('gridScroll');
		
		var _isTbl = null;
		var _isSrl = null;
		
		$(_div_table).mouseenter(function(){_isTbl = true; _isSrl = false;})
		$(_div_scroll).mouseenter(function(){_isSrl = true; _isTbl = false;})
		
		_div_table.addEventListener('scroll', function(){
			if(_isTbl){
				$(_div_scroll).scrollTop($(this).scrollTop());
			}
		},false)
		_div_scroll.addEventListener('scroll', function(){
			if(_isSrl){
				$(_div_table).scrollTop($(this).scrollTop());
			}
		},false)
		var _pos = $(_mst).position();
		$(_div_scroll).css({'height':_mdh+'px', 'top': _pos.top+'px', 'z-index': '99', 'right': '4px'});

		var _div_sr_bar = document.createElement("div");
		$(_div_sr_bar).addClass('secondDiv_scr');
		$(_div_sr_bar).css({'height':_tblH+'px'});//_tblH
		$(_div_scroll).append(_div_sr_bar);
		
		$($(_this).parent()).append(_div_scroll);
		/*scroll end */
		
		/*calc height of div on every click*/
		var _all_btn = $(_table).find('button');
		var _btn_arr = jQuery.makeArray(_all_btn);
		
		_btn_arr.forEach(function(item) {
			  item.addEventListener('click', function(){
				  dynamicScroll(_this);
			  })
		})
		
		dynamicScroll(_this);
		/*calc end*/
	},500)
	}
};
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
