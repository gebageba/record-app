import React from 'react'
import ReactDOM from 'react-dom'

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <div>
        <p>こんにちは</p>
    </div>,
    document.body.appendChild(document.createElement('div')),
  )
})