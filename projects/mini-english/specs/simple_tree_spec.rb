require 'rspec'

require '../classes/simple_tree'
require '../classes/simple_tree_node'

# Diese Testsuite beschreibt das Verhalten in der Klasse SimpleTree.
# Sie können hier auch einen String angeben, wenn Sie Tests schreiben,
# die sich nicht nur isoliert auf eine Klasse beziehen.
#
# Sie müssen vermutlich diese Testsuite an Ihre Klassen anpassen, was
# Namen und Pfade angeht. Benennen Sie jedoch nicht die Methoden hier
# im Test um, sondern passen Sie lieber Ihre Klassen an die hier
# benutzten Methodennamen an.
#
# Sie können dann diese Testsuite in der Shell / Eingabeaufforderung
# folgendermaßen aufrufen:
#
# rspec simple_tree_spec.rb
#
# Wenn Sie die Ausgabeformatierung ändern möchten, finden Sie Infos
# dazu über den Hilfetext von rspec:
#
# rspec -h
#
describe SimpleTree do

  # Ein Context beschreibt eine typische Konstellation von Daten, für
  # die sich mehrere einzelne Tests formulieren lassen - hier wird etwa
  # getestet, ob alle Methoden für einen neu erzeugten, leeren Baum
  # sich richtig verhalten.
  context 'A fresh, new tree' do

    # Code in diesem Konstrukt wird vor jedem Test in diesem Context
    # ausgeführt. So müssen Sie nicht in jedem Test einzeln einen neuen
    # Baum erzeugen.
    before :each do
      @tree = SimpleTree.new
    end

    # Der erste Test. Im String formulieren Sie eine Aussage, von der
    # Sie erwarten, dass sie zutrifft.
    it 'is empty' do
      @tree.empty?.should be true
    end

    it 'has a size of zero' do
      @tree.size.should be 0
    end

    it 'has no roots' do
      @tree.roots.should be_empty
    end

    it 'has a root count of zero' do
      @tree.root_count.should be 0
    end

    it 'has no leaves' do
      @tree.leaves.should be_empty
    end

    it 'has a leaf count of zero' do
      @tree.leaf_count.should be 0
    end

  end

  # Der nächste Context. Hier arbeiten wir mit einem
  # nichtleeren, kleinen Baum und gucken, ob die Methoden
  # immer noch das richtige tun.
  context 'The first example tree' do

    before :each do
      @tree = SimpleTree.new
      @np = SimpleTreeNode.new "NP"
      @d  = SimpleTreeNode.new "D"
      @n  = SimpleTreeNode.new "N"
      @tree.add_node @np
      @tree.add_node @d
      @tree.add_node @n
      @tree.link(@np, @d)
      @tree.link(@np, @n)
    end

    context 'considering roots' do

      it 'has one root' do
        @tree.root_count.should eq 1
      end

      it 'has NP as its root' do
        @tree.roots.first.should eq @np
      end

    end

    context 'considering leaves' do

      it 'has two leaves' do
        @tree.leaf_count.should eq 2
      end

      it 'has D as its first leaf' do
        @tree.leaves[0].should eq @d
      end

      it 'has N as its second leaf' do
        @tree.leaves[1].should eq @n
      end

    end

    context 'considering linkage' do

      it 'links NP to a child D' do
        @np.children.should include @d
      end

      it 'links NP to a child N' do
        @np.children.should include @n
      end

      it 'links D to a parent NP' do
        @d.parent.should be @np
      end

      it 'links N to a parent NP' do
        @n.parent.should be @np
      end

    end

    # Der dritte Kontext. Hier sollen Sie die Tests vervollständigen.

    context 'linking and moving nodes' do

      # Das ist das Setup für diesen Context:
      # Ein Baum mit Wurzel @a, darunter Kinder @b und @c, und
      # zusätzlich @d als isoliertes Element ohne Verlinkung
      before :each do
        @tree = SimpleTree.new
        @a = SimpleTreeNode.new "A"
        @b = SimpleTreeNode.new "B"
        @c = SimpleTreeNode.new "C"
        @d = SimpleTreeNode.new "D"

        @tree.add_node @a
        @tree.add_node @b
        @tree.add_node @c
        @tree.add_node @d

        @tree.link(@a, @b)
        @tree.link(@a, @c)
      end

      it 'reports correct info for isolated nodes' do
        # Testen Sie hier, ob für den isolierten Knoten @d (also einen Knoten,
        # an dem keine Kante anhängig ist) die korrekten Informationen bzgl.
        # Eltern und Kindern ermittelt werden (keine Eltern, keine Kinder, der
        # Knoten ist gleichzeitig Wurzel und Blatt).
        # Als Einstieg:
        @d.parent.should be_nil

        @d.children.should be_empty
        @d.is_root?.should be true
        @d.is_leaf?.should be true

      end

      it 'after linking, it reports correct parent-child information' do
        # In diesem Test sollen Sie prüfen, ob der Baum die korrekte
        # Eltern-Kind-Info liefert (Methoden parent, children, child_count),
        # wenn Sie jetzt den Knoten @d als Kind unter den Knoten @c hängen.

        @tree.link(@c, @d)

        @c.children.size.should be 1
        @c.children.first.should be @d
        @d.parent.should be @c

      end

      it 'ensures that no node ever gets more than one parent' do
        # Hängen Sie hier nun Knoten @c als Kind unter @b, und testen Sie,
        # ob @b danach immer noch höchstens ein Elternelement hat.

        @tree.link(@b, @c)
        @c.parent.should be @b

      end

    end

  end

end