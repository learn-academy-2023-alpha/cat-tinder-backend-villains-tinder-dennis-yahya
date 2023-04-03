villains = [
    {
        name: 'Joker',
        age: 34,
        enjoy: "Messing with Batman",
        img:"https://live.staticflickr.com/5448/30578142333_fd9ee3dcc5_b.jpg"
    },

    {
        name: 'Harley Quinn',
        age: 38,
        enjoy: "Puzzles and Games",
        img:"https://www.hdwallpapers.net/previews/harley-quinn-suicide-squad-1051.jpg"
    },

    {
        name: 'Thanos',
        age: 1000,
        enjoy: "Snapping and sunsets",
        img:"https://live.staticflickr.com/4816/32821316008_193c8c6de1_b.jpg"
    },

    {
        name: 'Wanda Maximoff',
        age: 28,
        enjoy: "Witchcraft and her kids and painting",
        img:"https://live.staticflickr.com/503/32029554902_45d9f9ab64_b.jpg"
    },
    {
        name: 'Green Goblin',
        age: 45,
        enjoy: "Being manipulative",
        img:"https://upload.wikimedia.org/wikipedia/commons/1/14/Willem_Dafoe_Cannes_2019.jpg"
    }
]
villains.each do |villain|
    Villain.create villain 
    puts "creating villain #{villain}"
end