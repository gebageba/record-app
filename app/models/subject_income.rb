class SubjectIncome < ActiveHash::Base
  self.data = [
    { id: 0, name: '--' },
    { id: 100, name: '1. 売上' }, { id: 101, name: '2. 事業主借' }, { id: 102, name: '3. 元入金' }
  ]
end
