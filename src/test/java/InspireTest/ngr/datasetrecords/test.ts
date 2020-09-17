
function xfilter(array1, array2) {
    return array1.filter(function (x) { return array2.indexOf(x) < 0; })
}

function Objectvalues(obj) {
    let vals = [];
    for (const prop in obj) {
    vals.push(obj[prop]);
    }
    return vals;
    }

let alphas1 = [ "http://inspire.ec.europa.eu/metadata-codelist/ResourceType",    "http://inspire.ec.europa.eu/metadata-codelist/TopicCategory" ]

let alphas2 = ["http://inspire.ec.europa.eu/metadata-codelist/ResourceType"]

console.log ("start2")
console.log(xfilter (Objectvalues(alphas1),Objectvalues(alphas2))); 