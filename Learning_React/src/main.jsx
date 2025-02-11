import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import App, { Exo1, TestProps, MyComponent, TodoList } from './App.jsx'

createRoot(document.getElementById('root')).render(
  <StrictMode>
    <MyComponent>
      <TodoList />
    </MyComponent>
    <Exo1 />

    <TestProps/>
    
  </StrictMode>,
)
