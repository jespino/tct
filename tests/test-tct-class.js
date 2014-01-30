var chai = require("chai")
var assert = chai.assert
var tct = require("../dist/tct")
var TCT = tct.TCT

describe('TCT', function(){
  describe('constructor', function(){
    it('should fail when no element is passed to the constructor', function(){
      assert.throws(function() {
          new TCT();
      }, "element parameter needed");
    })
    it('should fail when no element is passed to the constructor', function(){
      assert.throws(function() {
        new TCT('element');
      }, "element must have a keypress method");
    })
    it('should define a list of options with options parameter', function(){
      element = { keypress: function() {} };
      testTct = new TCT(element, ['test', 'list']);
      assert.sameMembers(testTct.options, ['test', 'list']);
    })
  })

  describe('getOptions', function(){
    it('must return no-result with a text of less than minLength', function(){
      element = { keypress: function() {} };
      options = [{key:'test1'}, {key:'test2'}, {key:'test3'}, {key:'test4'}]
      testTct = new TCT(element, options, { minLength: 1 });
      assert.sameMembers(testTct.getOptions(''), []);

      testTct = new TCT(element, options, { minLength: 10 });
      assert.sameMembers(testTct.getOptions('test'), []);

      testTct = new TCT(element, options, { minLength: 2 });
      assert.sameMembers(testTct.getOptions('tes'), options);
    })
    it('must return a list of members that starts with the parameter', function(){
      element = { keypress: function() {} };
      options = [{key:'test1'}, {key:'test2'}, {key:'test3'}, {key:'test4'}]
      testTct = new TCT(element, options);
      assert.sameMembers(testTct.getOptions('t'), options);

      testTct = new TCT(element, options);
      assert.sameMembers(testTct.getOptions('test1'), [options[0]]);
    })
    it('must return a list of members that starts with the parameter limited to the maxOptions', function(){
      element = { keypress: function() {} };
      options = [{key:'test1'}, {key:'test2'}, {key:'test3'}, {key:'test4'}]
      testTct = new TCT(element, options, {'maxOptions': 3});
      assert.sameMembers(testTct.getOptions('t'), [options[0], options[1], options[2]]);
    })
  })
})
