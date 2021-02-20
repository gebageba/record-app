import React, { useState } from 'react';
import explain from "./Second";
import { FaChevronLeft, FaChevronRight, FaQuoteRight } from 'react-icons/fa';

const Review = () => {
    const [index,setIndex] = useState(1);
    const {name,job,image,text} = explain[index];

    const checkNumber = (number) => {
      if (number > explain.length - 1){
        return 0
      }
      if (number < 0) {
        return explain.length - 1;
      }
      return number;
    };

    const nextExplain = () => {
      setIndex((index)=> {
          let newIndex = index + 1;
          return checkNumber(newIndex);
      });
    };
    const prevExplain = () => {
      setIndex((index)=> {
          let newIndex = index - 1;
          return checkNumber(newIndex);
      });
    };

    return (
        <article className="review">
            <div className="img-container">
                <img src={image} alt={name} className="person-img"/>
            </div>
            <h4 className="author">{name}</h4>
            <p className='job'>{job}</p>
            <p className='info'>{text}</p>
            <div className="button-container">
                <button className='prev-btn' onClick={prevExplain}>
                    <FaChevronLeft />
                </button>
                <button className='next-btn' onClick={nextExplain}>
                    <FaChevronRight />
                </button>
            </div>
            <button className='random-btn'>
                  <a href="/records/new">使ってみる</a>
            </button>
        </article>
    );
};

export default Review;