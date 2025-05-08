import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import App from './App.jsx'
import Gallery from './exo_component/test.jsx'

createRoot(document.getElementById('root')).render(
  <StrictMode>

    <App/>
    <Gallery/>
    
  </StrictMode>,
)
