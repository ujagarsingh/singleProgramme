import React, { Component } from 'react';
import Sidebar from './Sidebar';
import ExcelReader from './ExcelReader';
import SelectBox from './SelectBox';
//import { Chart } from 'react-charts'
import Chart from 'react-google-charts';

class MyChart extends Component {
    state = {
        selectnumber: '',
        dataObj: [],
        data: [
            {
                label: 'Series 1',
                data: [[0, 1], [1, 2], [2, 4], [3, 2], [4, 7]]
            },
            {
                label: 'Series 2',
                data: [[0, 3], [1, 1], [2, 5], [3, 6], [4, 4]]
            }
        ],
        axes: [
            { primary: true, type: 'linear', position: 'bottom' },
            { type: 'linear', position: 'left' }
        ],
    }

    render() {
        return (
            <div className="container">
                <div className="row">
                    <div className="col-sm-4">
                        <Sidebar />
                    </div>
                    <div className="col-sm-8">
                        <h2>Chart </h2>


                        <Chart
                            width={900}
                            height={500}
                            chartType="ColumnChart"
                            loader={<div>Loading Chart</div>}
                            data={[
                                ['City', '2010 Population', '2000 Population'],
                                ['New York City, NY', 8175000, 8008000],
                                ['Los Angeles, CA', 3792000, 3694000],
                                ['Chicago, IL', 2695000, 2896000],
                                ['Houston, TX', 2099000, 1953000],
                                ['Philadelphia, PA', 1526000, 1517000],
                            ]}
                            options={{
                                legend: { position: 'bottom', alignment: 'middle' },
                                title: 'Population of Largest U.S. Cities',
                                chartArea: { width: '100%' },
                                hAxis: {
                                    title: 'Total Population',
                                    minValue: 0,
                                },
                                vAxis: {
                                    title: 'City',
                                },
                            }}
                            legendToggle
                        />
                        <h2>Chart </h2>
                        <Chart
                            width={600}
                            height={300}
                            chartType="Line"
                            loader={<div>Loading Chart</div>}
                            data={[
                                [
                                    'Day',
                                    'Guardians of the Galaxy',
                                    'The Avengers',
                                    'Transformers: Age of Extinction',
                                ],
                                [1, 37.8, 80.8, 41.8],
                                [2, 30.9, 69.5, 32.4],
                                [3, 25.4, 57, 25.7],
                                [4, 11.7, 18.8, 10.5],
                                [5, 11.9, 17.6, 10.4],
                                [6, 8.8, 13.6, 7.7],
                                [7, 7.6, 12.3, 9.6],
                                [8, 12.3, 29.2, 10.6],
                                [9, 16.9, 42.9, 14.8],
                                [10, 12.8, 30.9, 11.6],
                                [11, 5.3, 7.9, 4.7],
                                [12, 6.6, 8.4, 5.2],
                                [13, 4.8, 6.3, 3.6],
                                [14, 4.2, 6.2, 3.4],
                            ]}
                            options={{
                                chart: {
                                    title: 'Box Office Earnings in First Two Weeks of Opening',
                                    subtitle: 'in millions of dollars (USD)',
                                },
                            }}
                        />

                    </div>

                </div>

            </div>

        );
    }
}

export default MyChart;
