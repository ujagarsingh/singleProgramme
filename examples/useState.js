import React, { useState } from 'react';

function App() {
  const [counter, setCounter] = useState(() => 4);
  const increment = () => {
    setCounter((preCount) => preCount + 1)
  }
  const decriment = () => {
    setCounter((preCount) => preCount - 1)
  }
  return (
    <div className="App" style={{ fontSize: "25px", textAlign: 'center' }}>
      <button onClick={increment}>+</button>
      <span>{counter}</span>
      <button onClick={decriment}>-</button>
    </div>
  );
}

export default App;
