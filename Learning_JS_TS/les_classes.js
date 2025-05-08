class Rectangle {

        // un contructeur de ma classe Rectangle
    constructor(lar, long) {
        this.largeur = lar
        this.longueur = long
    };

        // un getteur 
    get perimeter () {
        return 2 * (this.lar + this.long)
    };

    isvalid (lar, long) {
        return lar > 0 && long > 0
        
    };

    isBiggerThan (geometricForm) {
        return this.perimeter > geometricForm.perimeter
    };

};


class Squarre extends Rectangle {

    constructor(cote) {
        super(cote, cote)  // appelle le contructeur de la classe Rectangle
    };

    get surface() {
        return (this.largeur * this.longueur)
    };

    isBiggerThan (peri) {
        return this.perimeter > peri
    };

}; 


class Book {

    #page = 1

    constructor (title, pages) {
        this.title = title 
        this.numberOfPage = pages
    };

    get page() {
        return this.#page
    };

    nextPage() {
        return this.page + 1
    };

    close() {
        this.page = 1
    }

};


class Library {
    
    numberOfBook = []

    addBook (book) {
        return this.numberOfBook.push(book)
    };

    addBooks(books) {
        if (this.numberOfBook.length == 0) {
            return this.numberOfBook = books
        }
        return this.numberOfBook + books
        
    };

    finbBookByLetter(char) {

        this.numberOfBook.filter((word => word.title[0].toLowerCase() === char.toLowerCase()))
    };
}