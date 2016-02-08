LinterEslintView = require './linter-eslint-view'
{CompositeDisposable} = require 'atom'

module.exports = LinterEslint =
  linterEslintView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @linterEslintView = new LinterEslintView(state.linterEslintViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @linterEslintView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'linter-eslint:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @linterEslintView.destroy()

  serialize: ->
    linterEslintViewState: @linterEslintView.serialize()

  toggle: ->
    console.log 'LinterEslint was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
