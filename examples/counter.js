import React, { useState } from 'react';
import logo from './logo.svg';
import './App.css';

function App() {
  const [counter, setCounter] = useState(0);
  
  return (
    <div className="App">
      <h3>
        {counter}
      </h3>
      <button onClick={() => setCounter(counter + 1)}> + </button>
      <button onClick={() => setCounter(counter - 1)}> - </button>
    </div>
  );
}

export default App;
