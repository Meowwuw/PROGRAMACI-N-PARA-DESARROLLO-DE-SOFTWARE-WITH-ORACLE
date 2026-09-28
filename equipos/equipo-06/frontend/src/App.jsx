import React from 'react';
import ClientePage from "./pages/ClientePage.jsx";
import ReservaPage from "./pages/ReservaPage.jsx";

function App() {
  return (
    <div>
      <ClientePage />
      <hr style={{ margin: '40px 0', border: '1px solid #ccc' }} />
      <ReservaPage />
    </div>
  );
}

export default App;