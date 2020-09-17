function xfilter(array1, array2) {
    return array1.filter(function (x) { return array2.indexOf(x) < 0; });
}
function Objectvalues(obj) {
    var vals = [];
    for (var prop in obj) {
        vals.push(obj[prop]);
    }
    return vals;
}
var alphas1 = ["http://inspire.ec.europa.eu/metadata-codelist/ResourceType", "http://inspire.ec.europa.eu/metadata-codelist/TopicCategory"];
var alphas2 = ["http://inspire.ec.europa.eu/metadata-codelist/ResourceType"];
console.log("start2");
console.log(xfilter(Objectvalues(alphas1), Objectvalues(alphas2)));
