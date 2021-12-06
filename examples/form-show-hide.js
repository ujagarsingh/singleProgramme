import React, { useState } from 'react';
import './App.css';

function App() {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [working, setWorking] = useState(true);

  const onSubmitHandler = (event) => {
    event.preventDefault();
    const obj = { email, password }
    console.log(obj);
    setEmail('');
    setPassword('');
  }
  return (
    <div className="App">
      <button onClick={() => setWorking(!working)}>{working ? 'Hide' : 'Show' }</button>
      {working &&
        <form onSubmit={(event) => onSubmitHandler(event)}>
          <p>Email : <br />
            <input type='email'
              value={email}
              onChange={(event) => setEmail(event.target.value)}
            /></p>
          <p>password : <br /><input type='password' value={password}
            onChange={(event) => setPassword(event.target.value)}
          /></p>
          <p><button type='submit'>Submit</button></p>
        </form>
      }
    </div>
  );
}

export default App;
