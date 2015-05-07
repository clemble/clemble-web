describe "Match Directive", () ->

  element = undefined
  scope = undefined

  beforeEach(module("validation.match"))
  beforeEach inject ($compile, $rootScope) ->
    scope = $rootScope.$new();
    element = $compile('<form name="f"><input name="a" type="text" ng-model="a"></input><input name="b" type="text" ng-model="b" match="a"></input></form>')(scope);


  it "contains spec with an expectation", () ->
    scope.a = "A"
    scope.b = "B"
    scope.$digest()
    expect(scope.f.b.$error.match).toBe(true)

   it "contains spec with an expectation", () ->
    scope.a = "A"
    scope.b = "A"
    scope.$digest()
    expect(scope.f.b.$error.match).toBe(undefined)