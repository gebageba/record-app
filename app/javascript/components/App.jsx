import React, {Component} from 'react';
import Review from './Review';

function App() {
    return (
        <main>
            <section className='container'>
                <div className='title'>
                    <h3>よく読んでください</h3>
                    <div className="underline"></div>
                </div>
                <Review />
            </section>
        </main>
    )
}

export default App;