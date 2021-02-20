class Subject < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 1, name: '1. 外注工費' }, { id: 2, name: '2. 接待交際費' }, { id: 3, name: '3. 通信費' },
    { id: 4, name: '4. 広告宣伝費' }, { id: 5, name: '5. 支払手数料' }, { id: 6, name: '6. 消耗品費' },
    { id: 7, name: '7. 旅費交通費' }, { id: 8, name: '8. 水道光熱費' }, { id: 9, name: '9. 地代家賃' },
    { id: 10, name: '10. 荷造運賃' }, { id: 11, name: '11. 租税公課' }, { id: 12, name: '12. 修繕費' },
    { id: 13, name: '13. 損害保険料' }, { id: 14, name: '14. 会議費' }, { id: 15, name: '15. 新聞図書費' },
    { id: 16, name: '16. 研修費' }, { id: 17, name: '17. 雑貨' }, { id: 18, name: '18. 事業主貸' },
    { id: 100, name: '(1. 売上)' }, { id: 101, name: '(2. 事業主借)' }, { id: 102, name: '(3. 元入金)' }
  ]
end
